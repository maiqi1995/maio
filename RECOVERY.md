# Service Recovery Instructions

## Problem
The service is experiencing a memory issue (99.2%) and a startup deadlock caused by Prisma migrations.

## Solution Implemented

### 1. Railway Configuration Update
Created `railway.toml` to explicitly set the start command without running Prisma migrations:
```toml
[build]
command = "echo 'No build step needed for LiteLLM proxy'"

[deploy]
startCommand = "--config /app/config.yaml --port 4000"
```

### 2. Database Connection Optimization
If using Supabase, ensure the DATABASE_URL environment variable includes these parameters:
```
?pgbouncer=true&connection_limit=1
```

### 3. Dependency Analysis
This project uses the official LiteLLM Docker image (`ghcr.io/berriai/litellm:main-latest`), which should have optimized dependencies.

## Next Steps

### 1. Redeploy
Push these changes to Railway to trigger a redeployment:
```bash
git add .
git commit -m "Skip Prisma migrations on startup to fix memory issue"
git push railway master
```

### 2. Manual Migration
After the service is running, connect via Railway Exec and run the migration manually:
```bash
npx prisma migrate deploy
```

## Verification
1. Check that the service starts without the migration loop
2. Monitor memory usage to ensure it's below 90%
3. Test the API endpoints to ensure they're working correctly