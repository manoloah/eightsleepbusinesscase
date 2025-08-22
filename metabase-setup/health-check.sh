#!/bin/bash

# Health check script for Metabase services
echo "🔍 Checking Metabase services health..."

# Check if containers are running
echo "📦 Container Status:"
docker-compose ps

echo ""

# Check Metabase health endpoint
echo "🏥 Metabase Health Check:"
if curl -s http://localhost:3000/api/health > /dev/null; then
    echo "✅ Metabase is healthy and responding"
else
    echo "❌ Metabase health check failed"
fi

echo ""

# Check PostgreSQL connection
echo "🐘 PostgreSQL Health Check:"
if docker-compose exec -T postgres pg_isready -U metabase > /dev/null 2>&1; then
    echo "✅ PostgreSQL is healthy and accepting connections"
else
    echo "❌ PostgreSQL health check failed"
fi

echo ""

# Check service logs for errors
echo "📋 Recent Error Logs:"
docker-compose logs --tail=10 | grep -i error || echo "No recent errors found"

echo ""
echo "🎯 Health check complete!"
