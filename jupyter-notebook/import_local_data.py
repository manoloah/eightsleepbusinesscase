#!/usr/bin/env python3
"""
EightSleep Business Case - Local Data Import Script
Imports CSV data into local PostgreSQL database
"""

import pandas as pd
import os
import logging
from sqlalchemy import create_engine, text
import psycopg2

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Local PostgreSQL configuration
LOCAL_DB_CONFIG = {
    'host': 'localhost',
    'port': 5433,
    'database': 'eightsleep_local',
    'user': 'eightsleep_user',
    'password': 'eightsleep_password'
}

def create_local_db_engine():
    """Create SQLAlchemy engine for local PostgreSQL"""
    connection_string = f"postgresql://{LOCAL_DB_CONFIG['user']}:{LOCAL_DB_CONFIG['password']}@{LOCAL_DB_CONFIG['host']}:{LOCAL_DB_CONFIG['port']}/{LOCAL_DB_CONFIG['database']}"
    return create_engine(connection_string)

def test_connection():
    """Test connection to local PostgreSQL"""
    try:
        engine = create_local_db_engine()
        with engine.connect() as conn:
            result = conn.execute(text("SELECT version();"))
            version = result.fetchone()[0]
            logger.info(f"✅ Connected to PostgreSQL: {version}")
            return True
    except Exception as e:
        logger.error(f"❌ Failed to connect to local PostgreSQL: {e}")
        logger.info("Make sure to run: docker-compose -f docker-compose-local.yml up -d")
        return False

def clean_currency_column(df, column_name):
    """Clean currency columns by removing $ and , and converting to float"""
    if column_name in df.columns:
        df[column_name] = df[column_name].astype(str).str.replace('$', '').str.replace(',', '')
        df[column_name] = pd.to_numeric(df[column_name], errors='coerce')
    return df

def clean_numeric_column(df, column_name):
    """Clean numeric columns by removing , and converting to int"""
    if column_name in df.columns:
        df[column_name] = df[column_name].astype(str).str.replace(',', '')
        df[column_name] = pd.to_numeric(df[column_name], errors='coerce').astype('Int64')
    return df

def import_channel_performance(engine):
    """Import channel performance data to local database"""
    logger.info("Importing channel performance data to local database...")
    
    # Read CSV
    df = pd.read_csv('channel_performance.csv')
    
    # Clean data
    df = clean_currency_column(df, 'Spend')
    df = clean_currency_column(df, 'Last Click Revenue')
    df['Month'] = pd.to_datetime(df['Month']).dt.date
    
    # Rename columns to match database
    df = df.rename(columns={
        'Channel': 'channel',
        'Spend': 'spend',
        'Month': 'month',
        'Visitors': 'visitors',
        'Last Click Add To Cart': 'last_click_add_to_cart',
        'Last Click Orders': 'last_click_orders',
        'Last Click Revenue': 'last_click_revenue',
        'Last Click Email Captures': 'last_click_email_captures',
        'Email capture conversions 30 day window': 'email_capture_conversions_30_day',
        'Email capture conversions 60 day window': 'email_capture_conversions_60_day'
    })
    
    # Clear existing data and insert new data
    with engine.connect() as conn:
        conn.execute(text("DELETE FROM channel_performance"))
        conn.commit()
    
    # Insert data
    df.to_sql('channel_performance', engine, if_exists='append', index=False)
    logger.info(f"✅ Imported {len(df)} channel performance records to local database")

def import_wbr_global_data(engine):
    """Import WBR global data to local database"""
    logger.info("Importing WBR global data to local database...")
    
    # Read CSV
    df = pd.read_csv('wbr_Global_data.csv')
    
    # Clean data
    df = clean_currency_column(df, 'Daily Spend')
    df = clean_currency_column(df, 'Bookings')
    df['Date'] = pd.to_datetime(df['Date']).dt.date
    df = clean_numeric_column(df, 'Visitors')
    
    # Rename columns to match database
    df = df.rename(columns={
        'Date': 'date',
        'Daily Spend': 'daily_spend',
        'Orders': 'orders',
        'Bookings': 'bookings',
        'Visitors': 'visitors'
    })
    
    # Clear existing data and insert new data
    with engine.connect() as conn:
        conn.execute(text("DELETE FROM wbr_global_data"))
        conn.commit()
    
    # Insert data
    df.to_sql('wbr_global_data', engine, if_exists='append', index=False)
    logger.info(f"✅ Imported {len(df)} WBR global records to local database")

def import_wbr_regional_data(engine):
    """Import WBR regional data to local database"""
    logger.info("Importing WBR regional data to local database...")
    
    # Read CSV
    df = pd.read_csv('wbr_regional_data.csv')
    
    # Clean data - remove empty columns
    df = df.dropna(how='all', axis=1)
    
    # Clean currency columns
    df = clean_currency_column(df, 'Bookings')
    
    # Convert date
    df['Date'] = pd.to_datetime(df['Date']).dt.date
    
    # Rename columns to match database
    df = df.rename(columns={
        'Date': 'date',
        'Customer Type': 'customer_type',
        'Region': 'region',
        'Bookings': 'bookings',
        'Orders': 'orders',
        'Units': 'units'
    })
    
    # Clear existing data and insert new data
    with engine.connect() as conn:
        conn.execute(text("DELETE FROM wbr_regional_data"))
        conn.commit()
    
    # Insert data
    df.to_sql('wbr_regional_data', engine, if_exists='append', index=False)
    logger.info(f"✅ Imported {len(df)} WBR regional records to local database")

def verify_local_import(engine):
    """Verify the data import to local database"""
    logger.info("Verifying local data import...")
    
    # Check row counts
    with engine.connect() as conn:
        channel_count = conn.execute(text("SELECT COUNT(*) FROM channel_performance")).fetchone()[0]
        global_count = conn.execute(text("SELECT COUNT(*) FROM wbr_global_data")).fetchone()[0]
        regional_count = conn.execute(text("SELECT COUNT(*) FROM wbr_regional_data")).fetchone()[0]
    
    logger.info(f"Channel Performance: {channel_count} rows")
    logger.info(f"WBR Global Data: {global_count} rows")
    logger.info(f"WBR Regional Data: {regional_count} rows")
    
    # Show sample data
    logger.info("\nSample Channel Performance:")
    with engine.connect() as conn:
        sample = conn.execute(text("SELECT channel, spend, visitors FROM channel_performance LIMIT 3")).fetchall()
        for row in sample:
            logger.info(f"  {row[0]}: ${row[1]} - {row[2]} visitors")
    
    logger.info("\nSample WBR Global Data:")
    with engine.connect() as conn:
        sample = conn.execute(text("SELECT date, daily_spend, orders FROM wbr_global_data LIMIT 3")).fetchall()
        for row in sample:
            logger.info(f"  {row[0]}: ${row[1]} - {row[2]} orders")
    
    logger.info("\nSample WBR Regional Data:")
    with engine.connect() as conn:
        sample = conn.execute(text("SELECT date, customer_type, region, bookings FROM wbr_regional_data LIMIT 3")).fetchall()
        for row in sample:
            logger.info(f"  {row[0]} - {row[1]} - {row[2]}: ${row[3]}")

def main():
    """Main import function for local database"""
    logger.info("Starting EightSleep data import to local PostgreSQL...")
    
    # Check if CSV files exist
    required_files = [
        'channel_performance.csv',
        'wbr_Global_data.csv',
        'wbr_regional_data.csv'
    ]
    
    for file_path in required_files:
        if not os.path.exists(file_path):
            logger.error(f"Missing required file: {file_path}")
            return
    
    # Test connection
    if not test_connection():
        return
    
    try:
        # Create engine
        engine = create_local_db_engine()
        
        # Import all datasets to local database
        import_channel_performance(engine)
        import_wbr_global_data(engine)
        import_wbr_regional_data(engine)
        
        # Verify import
        verify_local_import(engine)
        
        logger.info("✅ Local data import completed successfully!")
        logger.info("🌐 You can now access pgAdmin at: http://localhost:8080")
        logger.info("   Email: admin@eightsleep.com")
        logger.info("   Password: admin123")
        logger.info("📊 Database: localhost:5433, eightsleep_local")
        
    except Exception as e:
        logger.error(f"❌ Local import failed: {str(e)}")
        raise

if __name__ == "__main__":
    main()
