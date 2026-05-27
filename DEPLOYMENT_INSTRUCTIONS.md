# Service Recovery Instructions

## Summary of Changes

1. **Modified Dockerfile** to skip automatic migrations during startup
2. **Created database optimizer script** to help optimize DATABASE_URL
3. **Prepared manual migration steps** for execution after service recovery

## Files Modified

- `Dockerfile`: Changed startup command to skip migrations
- `database-optimizer.sh`: Script to optimize database connection
- `DEPLOYMENT_INSTRUCTIONS.md`: This file

## Steps to Recover Service

### 1. Deploy to Railway

1. Push the updated code to Railway:
   ```
   git add .
   git commit -m "Skip automatic migrations to fix startup loop"
   git push railway main
   ```

2. Railway will automatically start building and deploying the container with the new Dockerfile configuration.

### 2. Optimize Database Connection (if using Supabase)

1. SSH into your Railway service or use the web console
2. Run the database optimizer script:
   ```
   ./database-optimizer.sh
   ```

3. If the script shows optimization is needed, update the Railway environment variable:
   - Go to your Railway project dashboard
   - Settings > Variables
   - Update or add the `DATABASE_URL` with the optimized version provided by the script

### 3. Manually Run Migrations (After Service is Running)

Once the service is successfully running without the migration loop:

1. SSH into your Railway service:
   ```
   railway exec
   ```

2. Run the migration command manually:
   ```
   # If using Prisma with this application
   npx prisma migrate deploy
   
   # Or the specific command used in your project
   # (This may need adjustment based on your actual setup)
   ```

## Verification

1. Check that the service is running without errors:
   ```
   railway logs
   ```

2. Verify the service is responding:
   ```
   curl http://your-service-url:4000/health  # or appropriate endpoint
   ```

## Additional Notes

- The `--start` flag in the Dockerfile CMD should prevent the application from trying to run migrations during startup
- If you encounter any issues, check the Railway logs for error messages
- The database optimizer script is only needed if you're using Supabase

## Next Steps

After the service is running and migrations are completed:
1. Monitor memory usage to ensure it's stable
2. Consider if any additional optimizations are needed
3. Update any monitoring or alerting configurations if needed