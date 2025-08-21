# Connecting Metabase to Supabase

## Prerequisites
- Metabase instance running (via Docker Compose or V0)
- Supabase project with database credentials

## Connection Steps

### 1. Access Metabase
- Open your Metabase instance (http://localhost:3000 or your V0 URL)
- Complete the initial setup if this is your first time

### 2. Add Supabase Database
1. Go to **Settings** → **Databases**
2. Click **Add Database**
3. Select **PostgreSQL** as the database type

### 3. Connection Details
Use these connection parameters for your Supabase database:

```
Host: db.[YOUR_PROJECT_REF].supabase.co
Port: 5432
Database: postgres
Username: postgres
Password: [YOUR_DB_PASSWORD]
```

### 4. Advanced Options
- **SSL Mode**: Require
- **Schema**: public (or your custom schema)
- **Additional Connection Options**: 
  ```
  sslmode=require&sslcert=&sslkey=&sslrootcert=
  ```

### 5. Test Connection
- Click **Test Connection** to verify
- If successful, click **Save**

## V0 Deployment Notes
When deploying to V0:
- The Metabase instance will be accessible via your V0 project URL
- You can connect to your Supabase database from the V0-hosted Metabase
- Ensure your Supabase database allows connections from V0's IP ranges

## Security Considerations
- Use environment variables for sensitive connection details
- Consider using connection pooling for production use
- Regularly rotate database passwords
- Use SSL connections (required for Supabase)

## Troubleshooting
- **Connection timeout**: Check firewall settings and Supabase network policies
- **SSL errors**: Ensure SSL mode is set to "require"
- **Authentication failed**: Verify username/password and check Supabase dashboard
