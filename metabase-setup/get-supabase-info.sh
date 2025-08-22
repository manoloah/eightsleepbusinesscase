#!/bin/bash

# Script to get Supabase project information and update Metabase configuration
echo "🔍 Getting Supabase project information for 'eightsleepbusinesscase'..."

# Check if Supabase CLI is installed
if ! command -v supabase &> /dev/null; then
    echo "📥 Installing Supabase CLI..."
    npm install -g supabase
fi

# Login to Supabase (if not already logged in)
echo "🔐 Logging into Supabase..."
supabase login

# Get project information
echo "📊 Getting project details..."
PROJECT_INFO=$(supabase projects list --json | jq -r '.[] | select(.name == "eightsleepbusinesscase")')

if [ -z "$PROJECT_INFO" ]; then
    echo "❌ Project 'eightsleepbusinesscase' not found!"
    echo "Available projects:"
    supabase projects list
    exit 1
fi

# Extract project details
PROJECT_ID=$(echo "$PROJECT_INFO" | jq -r '.id')
PROJECT_REF=$(echo "$PROJECT_INFO" | jq -r '.reference_id')
PROJECT_REGION=$(echo "$PROJECT_INFO" | jq -r '.region')

echo "✅ Project found!"
echo "📋 Project ID: $PROJECT_ID"
echo "🔗 Project Ref: $PROJECT_REF"
echo "🌍 Region: $PROJECT_REGION"

# Get database connection details
echo "🗄️ Getting database connection details..."
DB_HOST="db.$PROJECT_REF.supabase.co"
DB_PORT="5432"
DB_NAME="postgres"

echo "📊 Database Connection Details:"
echo "Host: $DB_HOST"
echo "Port: $DB_PORT"
echo "Database: $DB_NAME"
echo "Username: postgres"
echo "Password: [Check your Supabase dashboard]"

# Update environment file
echo "📝 Updating environment configuration..."
cat > .env << EOF
# Metabase Configuration
MB_DB_TYPE=postgres
MB_DB_DBNAME=metabase
MB_DB_PORT=5432
MB_DB_USER=metabase
MB_DB_PASS=metabase_password
MB_DB_HOST=postgres
JAVA_TIMEZONE=UTC

# PostgreSQL Configuration
POSTGRES_USER=metabase
POSTGRES_PASSWORD=metabase_password
POSTGRES_DB=metabase

# V0 Deployment
V0_PROJECT_NAME=metabase-dashboard
V0_DOMAIN=your-project.v0.dev

# Supabase Connection Details
SUPABASE_PROJECT_ID=$PROJECT_ID
SUPABASE_PROJECT_REF=$PROJECT_REF
SUPABASE_DB_HOST=$DB_HOST
SUPABASE_DB_PORT=$DB_PORT
SUPABASE_DB_NAME=$DB_NAME
SUPABASE_DB_USER=postgres
EOF

echo "✅ Environment file updated with Supabase details!"

# Create Metabase Supabase connection guide
echo "📚 Creating Metabase-Supabase connection guide..."
cat > metabase-supabase-setup.md << EOF
# Metabase + Supabase Connection Setup

## Project Details
- **Project Name**: eightsleepbusinesscase
- **Project ID**: $PROJECT_ID
- **Project Ref**: $PROJECT_REF
- **Region**: $PROJECT_REGION

## Database Connection Parameters

### For Metabase Database Connection:
1. Go to Metabase → Settings → Databases
2. Click "Add Database"
3. Select "PostgreSQL"
4. Use these connection details:

\`\`\`
Host: $DB_HOST
Port: $DB_PORT
Database: $DB_NAME
Username: postgres
Password: [Your Supabase database password]
\`\`\`

### Advanced Options:
- **SSL Mode**: Require
- **Schema**: public
- **Additional Connection Options**: 
  \`\`\`
  sslmode=require&sslcert=&sslkey=&sslrootcert=
  \`\`\`

## Getting Your Database Password
1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Select project: eightsleepbusinesscase
3. Go to Settings → Database
4. Copy the database password

## Testing Connection
1. Click "Test Connection" in Metabase
2. If successful, click "Save"
3. Your Supabase data will now be available in Metabase!

## Next Steps
1. Import your EightSleep business case data into Supabase
2. Create dashboards and visualizations in Metabase
3. Analyze your data for business insights
EOF

echo "✅ Connection guide created: metabase-supabase-setup.md"

echo ""
echo "🎯 Next steps:"
echo "1. Get your database password from Supabase dashboard"
echo "2. Update the .env file with your password"
echo "3. Deploy Metabase using: ./deploy.sh"
echo "4. Follow the connection guide in metabase-supabase-setup.md"
echo ""
echo "🚀 Ready to connect Metabase to your Supabase project!"
