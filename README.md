# EightSleep Business Case - Metabase Dashboard

This repository contains a Metabase instance setup for analyzing EightSleep business case data. The dashboard will be deployed on V0 for easy access and collaboration.

## 🚀 Quick Start

### Local Development
1. **Prerequisites**
   - Docker and Docker Compose installed
   - Git repository cloned

2. **Deploy Locally**
   ```bash
   # Make deploy script executable
   chmod +x deploy.sh
   
   # Run deployment
   ./deploy.sh
   ```

3. **Access Metabase**
   - Open http://localhost:3000
   - Complete initial setup wizard
   - Connect to your Supabase database

### V0 Deployment
1. **Push to V0**
   - The `v0.json` file is configured for easy V0 deployment
   - V0 will automatically detect the Docker Compose setup
   - Your Metabase instance will be available at your V0 project URL

2. **Environment Setup**
   - Copy `env.example` to `.env` and configure your settings
   - Update Supabase connection details in the environment file

## 📊 Features

- **Metabase Instance**: Latest version with PostgreSQL backend
- **Docker Compose**: Easy local development and testing
- **V0 Ready**: Optimized for V0 deployment
- **Supabase Integration**: Ready to connect to your Supabase project
- **Health Checks**: Built-in monitoring and restart policies

## 🔧 Configuration

### Environment Variables
- `MB_DB_TYPE`: Database type (postgres)
- `MB_DB_HOST`: Database host
- `MB_DB_PORT`: Database port
- `MB_DB_USER`: Database username
- `MB_DB_PASS`: Database password
- `JAVA_TIMEZONE`: Timezone setting

### Ports
- **3000**: Metabase web interface
- **5432**: PostgreSQL database (internal)

## 📁 Project Structure

```
├── docker-compose.yml      # Main deployment configuration
├── Dockerfile             # Custom Metabase build (optional)
├── v0.json               # V0 deployment configuration
├── env.example           # Environment variables template
├── deploy.sh             # Local deployment script
├── supabase-connection.md # Supabase connection guide
└── README.md             # This file
```

## 🔗 Connecting to Supabase

1. **Get Supabase Credentials**
   - Host: `db.lmokzxpktcchregvna.supabase.co`
   - Port: `5432`
   - Database: `postgres`
   - Username: `postgres`
   - Password: Your database password

   **Project Details**: eightsleepbusinesscase (ID: lmokzxpktcchregvna)

2. **SSL Configuration**
   - SSL Mode: `Require`
   - Additional options: `sslmode=require`

3. **Test Connection**
   - Use Metabase's built-in connection tester
   - Verify connectivity before proceeding

## 🚀 V0 Deployment Steps

1. **Push to V0**
   ```bash
   git add .
   git commit -m "Setup Metabase for V0 deployment"
   git push
   ```

2. **Deploy on V0**
   - V0 will automatically detect the Docker Compose setup
   - The `v0.json` file provides deployment configuration
   - Your Metabase instance will be publicly accessible

3. **Configure Supabase Connection**
   - Follow the connection guide in `supabase-connection.md`
   - Ensure your Supabase project allows external connections

## 📈 Next Steps

1. **Data Import**: Import your EightSleep business case data into Supabase
2. **Dashboard Creation**: Build visualizations and dashboards in Metabase
3. **Analysis**: Perform business case analysis using the dashboard
4. **Collaboration**: Share insights with stakeholders via V0 deployment

## 🛠️ Troubleshooting

### Common Issues
- **Port conflicts**: Ensure port 3000 is available
- **Database connection**: Verify Supabase credentials and network access
- **SSL errors**: Check SSL configuration for Supabase connection

### Commands
```bash
# View logs
docker-compose logs -f metabase

# Restart services
docker-compose restart

# Stop all services
docker-compose down

# View running containers
docker-compose ps
```

## 📚 Resources

- [Metabase Documentation](https://www.metabase.com/docs/latest/)
- [Supabase Documentation](https://supabase.com/docs)
- [V0 Documentation](https://v0.dev/docs)
- [Docker Compose Reference](https://docs.docker.com/compose/)

## 🤝 Contributing

This setup is designed for the EightSleep business case analysis. Feel free to modify configurations and add customizations as needed for your specific analysis requirements.

---

**Ready to analyze EightSleep data! 🎯**
