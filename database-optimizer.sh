#!/bin/bash

# Database Connection Optimizer Script
# This script helps optimize the DATABASE_URL for memory usage

echo "=== Database Connection Optimizer ==="
echo ""

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
    echo "ERROR: DATABASE_URL environment variable is not set."
    echo "Please set your DATABASE_URL before running this script."
    exit 1
fi

echo "Current DATABASE_URL:"
echo "$DATABASE_URL"
echo ""

# Check if it's a Supabase URL
if [[ $DATABASE_URL == *supabase* ]]; then
    echo "Detected Supabase database connection"
    
    # Check if pgbouncer parameters are already present
    if [[ $DATABASE_URL == *"pgbouncer=true"* ]]; then
        echo "✓ pgbouncer=true is already configured"
    else
        echo "⚠ Adding pgbouncer=true to optimize connection pooling"
    fi
    
    if [[ $DATABASE_URL == *"connection_limit=1"* ]]; then
        echo "✓ connection_limit=1 is already configured"
    else
        echo "⚠ Adding connection_limit=1 to reduce memory usage"
    fi
    
    # Add pgbouncer parameters if not present
    if [[ $DATABASE_URL != *"pgbouncer=true"* ]] || [[ $DATABASE_URL != *"connection_limit=1"* ]]; then
        # Remove existing query string if present
        BASE_URL="${DATABASE_URL%\?*}"
        QUERY_STRING="${DATABASE_URL#*\?}"
        
        # Build new query string with pgbouncer parameters
        if [[ -n "$QUERY_STRING" ]]; then
            NEW_QUERY_STRING="${QUERY_STRING}&pgbouncer=true&connection_limit=1"
        else
            NEW_QUERY_STRING="pgbouncer=true&connection_limit=1"
        fi
        
        OPTIMIZED_URL="${BASE_URL}?${NEW_QUERY_STRING}"
        echo ""
        echo "Optimized DATABASE_URL:"
        echo "$OPTIMIZED_URL"
        echo ""
        echo "To apply this change, set the following environment variable in Railway:"
        echo "DATABASE_URL=$OPTIMIZED_URL"
    else
        echo ""
        echo "Your DATABASE_URL is already optimized for memory usage."
    fi
else
    echo "This database is not Supabase."
    echo "If you're using a different database provider, please check their documentation"
    echo "for connection pooling or memory optimization options."
fi

echo ""
echo "=== End of Database Connection Optimizer ==="