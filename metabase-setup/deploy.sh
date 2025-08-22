#!/bin/bash

# EightSleep Metabase Deployment Script
echo "🚀 Deploying Metabase for EightSleep Business Case..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install it and try again."
    exit 1
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp env.example .env
    echo "✅ .env file created. Please review and modify if needed."
fi

# Pull latest images
echo "📥 Pulling latest Docker images..."
docker-compose pull

# Start services
echo "🚀 Starting Metabase services..."
docker-compose up -d

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 30

# Check service status
echo "🔍 Checking service status..."
docker-compose ps

# Get Metabase URL
echo ""
echo "✅ Metabase is now running!"
echo "🌐 Access your dashboard at: http://localhost:3000"
echo ""
echo "📊 Initial setup steps:"
echo "1. Open http://localhost:3000 in your browser"
echo "2. Complete the initial setup wizard"
echo "3. Connect to your Supabase database using the connection details"
echo ""
echo "🔧 To stop services: docker-compose down"
echo "🔧 To view logs: docker-compose logs -f metabase"
echo ""
echo "🎯 Ready for EightSleep business case analysis!"
