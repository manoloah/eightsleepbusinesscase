# Metabase + Supabase Connection Setup

## 🎯 Project Details
- **Project Name**: eightsleepbusinesscase
- **Project ID**: lmokzxpktcchregvna
- **Project Ref**: lmokzxpk
- **Region**: us-west-1
- **Database Host**: db.lmokzxpktcchregvna.supabase.co

## 🚀 Quick Connection Steps

### 1. Deploy Metabase
```bash
# Make sure you're in the project directory
cd eightsleepbusinesscase

# Deploy Metabase locally
./deploy.sh

# Or deploy to V0 (recommended for business case)
git add .
git commit -m "Setup Metabase for EightSleep business case"
git push
```

### 2. Access Metabase
- **Local**: http://localhost:3000
- **V0**: Your V0 project URL (will be provided after deployment)

### 3. Complete Initial Setup
1. Open Metabase in your browser
2. Follow the setup wizard
3. Create your admin account
4. Skip the sample database (we'll add Supabase)

### 4. Connect to Supabase Database

#### Step 1: Add Database
1. Go to **Settings** → **Databases**
2. Click **Add Database**
3. Select **PostgreSQL**

#### Step 2: Connection Details
Use these exact parameters:

```
Host: db.lmokzxpktcchregvna.supabase.co
Port: 5432
Database: postgres
Username: postgres
Password: [Your Supabase database password]
```

#### Step 3: Advanced Options
- **SSL Mode**: Require
- **Schema**: public
- **Additional Connection Options**: 
  ```
  sslmode=require&sslcert=&sslkey=&sslrootcert=
  ```

#### Step 4: Test & Save
1. Click **Test Connection**
2. If successful, click **Save**
3. Your Supabase data is now available in Metabase!

## 🔐 Getting Your Database Password

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Select project: **eightsleepbusinesscase**
3. Navigate to **Settings** → **Database**
4. Copy the **Database Password**
5. Use this password in the Metabase connection

## 📊 Database Connection Summary

| Parameter | Value |
|-----------|-------|
| **Host** | `db.lmokzxpktcchregvna.supabase.co` |
| **Port** | `5432` |
| **Database** | `postgres` |
| **Username** | `postgres` |
| **Password** | [From Supabase Dashboard] |
| **SSL Mode** | `Require` |
| **Schema** | `public` |

## 🎯 EightSleep Business Case Setup

### Data Import Steps
1. **Prepare Your Data**: Ensure your business case data is in CSV, JSON, or SQL format
2. **Import to Supabase**: Use Supabase's table editor or SQL editor to import data
3. **Verify Tables**: Check that your data appears in the Supabase dashboard
4. **Connect Metabase**: Follow the connection steps above

### Recommended Dashboard Structure
- **Overview Dashboard**: Key metrics and KPIs
- **Data Analysis**: Detailed breakdowns and insights
- **Business Metrics**: Revenue, growth, and performance indicators
- **Comparative Analysis**: Before/after scenarios or competitive analysis

## 🚨 Troubleshooting

### Common Issues

#### Connection Timeout
- Check if your Supabase project is active
- Verify the host address is correct
- Ensure port 5432 is accessible

#### SSL Errors
- **SSL Mode must be set to "Require"**
- Check that you're using the correct host
- Verify your Supabase project is in a supported region

#### Authentication Failed
- Double-check username: `postgres`
- Verify password from Supabase dashboard
- Ensure your IP is not blocked by Supabase policies

#### Database Not Found
- Confirm database name is `postgres` (not `eightsleepbusinesscase`)
- Check that your Supabase project is active
- Verify you have the correct project ID

### Debug Commands
```bash
# Test database connectivity
nc -zv db.lmokzxpktcchregvna.supabase.co 5432

# Check Metabase logs
docker-compose logs -f metabase

# Test Supabase API
curl -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  "https://api.supabase.com/v1/projects/lmokzxpktcchregvna"
```

## 🔄 Next Steps After Connection

1. **Explore Your Data**: Use Metabase's data browser to see your tables
2. **Create Questions**: Build custom queries and visualizations
3. **Design Dashboards**: Combine multiple visualizations into dashboards
4. **Share Insights**: Export or share your analysis with stakeholders
5. **Iterate**: Refine your dashboards based on feedback

## 📚 Additional Resources

- [Metabase Documentation](https://www.metabase.com/docs/latest/)
- [Supabase Documentation](https://supabase.com/docs)
- [PostgreSQL Connection Guide](https://supabase.com/docs/guides/database/connecting-to-postgres)
- [V0 Deployment Guide](https://v0.dev/docs)

---

## 🎉 Success Checklist

- [ ] Metabase deployed (local or V0)
- [ ] Initial setup completed
- [ ] Supabase database connected
- [ ] Data tables visible in Metabase
- [ ] First dashboard created
- [ ] Business case analysis started

**Ready to analyze EightSleep data! 🚀**
