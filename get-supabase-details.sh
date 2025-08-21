#!/bin/bash

# Simple script to get Supabase project details using access token
echo "🔍 Getting Supabase project details for 'eightsleepbusinesscase'..."

# Your Supabase access token (from MCP config)
ACCESS_TOKEN="sbp_79bed6485dc1ae8da8887388549110ebf3586605"

# Get project information via Supabase API
echo "📊 Fetching project details..."
PROJECT_RESPONSE=$(curl -s -H "Authorization: Bearer $ACCESS_TOKEN" \
  "https://api.supabase.com/v1/projects")

# Debug: show the response structure
echo "🔍 API Response structure:"
echo "$PROJECT_RESPONSE" | jq '.[0] | keys'

# Find the specific project
PROJECT_INFO=$(echo "$PROJECT_RESPONSE" | jq -r '.[] | select(.name == "eightsleepbusinesscase")')

if [ -z "$PROJECT_INFO" ] || [ "$PROJECT_INFO" = "null" ]; then
    echo "❌ Project 'eightsleepbusinesscase' not found!"
    echo "Available projects:"
    echo "$PROJECT_RESPONSE" | jq -r '.[].name'
    exit 1
fi

echo "🔍 Raw project info:"
echo "$PROJECT_INFO" | jq '.'

# Extract project details - try different possible field names
PROJECT_ID=$(echo "$PROJECT_INFO" | jq -r '.id // .project_id')
PROJECT_REF=$(echo "$PROJECT_INFO" | jq -r '.reference_id // .ref // .project_ref')
PROJECT_REGION=$(echo "$PROJECT_INFO" | jq -r '.region // .region_id')

echo "✅ Project found!"
echo "📋 Project ID: $PROJECT_ID"
echo "🔗 Project Ref: $PROJECT_REF"
echo "🌍 Region: $PROJECT_REGION"

# If reference is still null, try to construct it from the project ID
if [ "$PROJECT_REF" = "null" ] || [ -z "$PROJECT_REF" ]; then
    echo "⚠️  Project reference not found, trying alternative method..."
    # Try to get the reference from the project URL or construct it
    PROJECT_REF=$(echo "$PROJECT_ID" | cut -c1-8)
    echo "🔗 Constructed Project Ref: $PROJECT_REF"
fi

# Database connection details - use the actual host from the API response
DB_HOST=$(echo "$PROJECT_INFO" | jq -r '.database.host')
DB_PORT="5432"
DB_NAME="postgres"

echo ""
echo "📊 Database Connection Details for Metabase:"
echo "Host: $DB_HOST"
echo "Port: $DB_PORT"
echo "Database: $DB_NAME"
echo "Username: postgres"
echo "Password: [Get from Supabase Dashboard → Settings → Database]"
echo "SSL Mode: Require"

# Update .env file with Supabase details
echo ""
echo "📝 Updating .env file with Supabase details..."
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

echo "✅ .env file created!"

echo ""
echo "🎯 Next steps:"
echo "1. Get your database password from: https://supabase.com/dashboard/project/$PROJECT_ID/settings/database"
echo "2. Deploy Metabase: ./deploy.sh"
echo "3. In Metabase, add database with these connection details:"
echo "   - Host: $DB_HOST"
echo "   - Port: $DB_PORT"
echo "   - Database: $DB_NAME"
echo "   - Username: postgres"
echo "   - SSL Mode: Require"
echo ""
echo "🚀 Ready to connect Metabase to your Supabase project!"
