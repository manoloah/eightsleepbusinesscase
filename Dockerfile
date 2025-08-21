FROM metabase/metabase:latest

# Set environment variables
ENV MB_DB_TYPE=postgres
ENV JAVA_TIMEZONE=UTC

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:3000/api/health || exit 1
