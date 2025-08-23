#!/bin/bash

# Railway Deployment Script for Metabase
echo "🚂 Deploying Metabase to Railway..."

# Check if we're in the right directory
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Please run this script from the metabase-setup directory"
    exit 1
fi

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file from railway.env template..."
    cp railway.env .env
    echo "✅ .env file created from railway.env"
    echo "⚠️  Please update the .env file with your actual Supabase credentials before deploying"
    echo ""
    echo "Required variables to update:"
    echo "  - SUPABASE_DB_PASSWORD: Your Supabase database password"
    echo "  - MB_ENCRYPTION_SECRET_KEY: A random 32-character string"
    echo ""
    echo "You can generate a secret key with: openssl rand -hex 16"
    exit 0
fi

# Check if required environment variables are set
if ! grep -q "SUPABASE_DB_PASSWORD" .env || ! grep -q "MB_ENCRYPTION_SECRET_KEY" .env; then
    echo "❌ Please update your .env file with the required credentials:"
    echo "   - SUPABASE_DB_PASSWORD"
    echo "   - MB_ENCRYPTION_SECRET_KEY"
    echo ""
    echo "You can generate a secret key with: openssl rand -hex 16"
    exit 1
fi

echo "✅ Environment configuration looks good!"
echo ""
echo "🚀 Ready to deploy to Railway!"
echo ""
echo "Next steps:"
echo "1. Push your code to GitHub:"
echo "   git add ."
echo "   git commit -m 'Configure Metabase for Railway deployment'"
echo "   git push"
echo ""
echo "2. In Railway dashboard:"
echo "   - Connect your GitHub repository"
echo "   - Set the environment variables from your .env file"
echo "   - Deploy!"
echo ""
echo "3. After deployment, Metabase will be available at your Railway URL"
echo ""
echo "🎯 Good luck with your EightSleep business case dashboard!"
