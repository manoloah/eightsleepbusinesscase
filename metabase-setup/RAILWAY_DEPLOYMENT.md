# Railway Deployment Guide for Metabase

This guide will help you deploy Metabase to Railway without the database connection issues you're experiencing.

## 🚨 Problem Identified

The error `java.net.UnknownHostException: postgres` occurs because:
1. Your Docker Compose file was trying to connect to a local PostgreSQL service named "postgres"
2. Railway doesn't have this service, causing the connection to fail
3. Metabase needs a database to start up

## ✅ Solution

We've updated the configuration to:
1. Remove the local PostgreSQL dependency
2. Configure Metabase to use your existing Supabase database
3. Make the Docker Compose file Railway-compatible

## 🚀 Deployment Steps

### 1. Set Railway Environment Variables

In your Railway project dashboard, add these environment variables:

```bash
# Database Configuration
MB_DB_TYPE=postgres
MB_DB_DBNAME=postgres
MB_DB_PORT=5432
MB_DB_USER=postgres
MB_DB_PASS=your_supabase_password_here
MB_DB_HOST=db.lmokzxpktcchregvna.supabase.co

# SSL Configuration
MB_DB_SSL=true
MB_DB_SSL_MODE=require

# Metabase Settings
JAVA_TIMEZONE=UTC
MB_ENCRYPTION_SECRET_KEY=your-random-secret-key-here
```

### 2. Get Your Supabase Password

If you don't have your Supabase database password:
1. Go to your Supabase project dashboard
2. Navigate to Settings > Database
3. Copy the database password

### 3. Generate Encryption Secret

Generate a random 32-character string for `MB_ENCRYPTION_SECRET_KEY`:
```bash
# On macOS/Linux
openssl rand -hex 16
```

### 4. Deploy to Railway

1. Push your updated code to GitHub
2. Connect your repository to Railway
3. Railway will automatically detect the Docker Compose setup
4. The deployment should now succeed

## 🔧 Configuration Details

### Updated Docker Compose File
- Removed PostgreSQL service dependency
- Added environment variable support
- Added health checks
- Railway-compatible configuration

### Database Connection
- **Host**: `db.lmokzxpktcchregvna.supabase.co`
- **Database**: `postgres`
- **Username**: `postgres`
- **SSL**: Required
- **Port**: 5432

## 🧪 Testing the Connection

After deployment, Metabase will:
1. Start up successfully
2. Connect to your Supabase database
3. Be available at your Railway URL

## 🚨 Common Issues & Solutions

### Issue: Still getting connection errors
**Solution**: Verify your Supabase credentials and ensure the database is accessible from Railway's IP range.

### Issue: Metabase starts but can't see tables
**Solution**: Check that your Supabase RLS policies allow the postgres user to read the tables.

### Issue: SSL connection errors
**Solution**: Ensure `MB_DB_SSL=true` and `MB_DB_SSL_MODE=require` are set.

## 📊 Next Steps

Once deployed:
1. Access Metabase at your Railway URL
2. Complete the initial setup wizard
3. Connect to your Supabase database
4. Start building your EightSleep business case dashboard!

## 🔗 Useful Links

- [Railway Documentation](https://docs.railway.app/)
- [Metabase Documentation](https://www.metabase.com/docs/latest/)
- [Supabase Documentation](https://supabase.com/docs)
