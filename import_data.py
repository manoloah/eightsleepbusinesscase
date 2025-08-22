#!/usr/bin/env python3
"""
EightSleep Business Case - Data Import Script
Imports all CSV datasets into Supabase database
"""

import pandas as pd
import os
from supabase import create_client, Client
import logging

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Supabase configuration
SUPABASE_URL = "https://lmokzxpktcchregvavna.supabase.co"
SUPABASE_KEY = "YOUR_SUPABASE_ANON_KEY"  # Get this from your Supabase dashboard

def create_supabase_client() -> Client:
    """Create Supabase client"""
    return create_client(SUPABASE_URL, SUPABASE_KEY)

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

def import_channel_performance(supabase: Client):
    """Import channel performance data"""
    logger.info("Importing channel performance data...")
    
    # Read CSV
    df = pd.read_csv('datasets/channel_performance.csv')
    
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
    
    # Convert to records and insert
    records = df.to_dict('records')
    
    # Clear existing data
    supabase.table('channel_performance').delete().neq('id', 0).execute()
    
    # Insert new data
    result = supabase.table('channel_performance').insert(records).execute()
    logger.info(f"Imported {len(records)} channel performance records")

def import_wbr_global_data(supabase: Client):
    """Import WBR global data"""
    logger.info("Importing WBR global data...")
    
    # Read CSV
    df = pd.read_csv('datasets/wbr_Global_data.csv')
    
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
    
    # Convert to records and insert
    records = df.to_dict('records')
    
    # Clear existing data
    supabase.table('wbr_global_data').delete().neq('id', 0).execute()
    
    # Insert new data
    result = supabase.table('wbr_global_data').insert(records).execute()
    logger.info(f"Imported {len(records)} WBR global records")

def import_wbr_regional_data(supabase: Client):
    """Import WBR regional data"""
    logger.info("Importing WBR regional data...")
    
    # Read CSV
    df = pd.read_csv('datasets/wbr_regional_data.csv')
    
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
    
    # Convert to records and insert
    records = df.to_dict('records')
    
    # Clear existing data
    supabase.table('wbr_regional_data').delete().neq('id', 0).execute()
    
    # Insert new data
    result = supabase.table('wbr_regional_data').insert(records).execute()
    logger.info(f"Imported {len(records)} WBR regional records")

def verify_import(supabase: Client):
    """Verify the data import"""
    logger.info("Verifying data import...")
    
    # Check row counts
    channel_count = supabase.table('channel_performance').select('*', count='exact').execute()
    global_count = supabase.table('wbr_global_data').select('*', count='exact').execute()
    regional_count = supabase.table('wbr_regional_data').select('*', count='exact').execute()
    
    logger.info(f"Channel Performance: {channel_count.count} rows")
    logger.info(f"WBR Global Data: {global_count.count} rows")
    logger.info(f"WBR Regional Data: {regional_count.count} rows")
    
    # Show sample data
    logger.info("\nSample Channel Performance:")
    sample = supabase.table('channel_performance').select('*').limit(3).execute()
    for row in sample.data:
        logger.info(f"  {row['channel']}: ${row['spend']} - {row['visitors']} visitors")
    
    logger.info("\nSample WBR Global Data:")
    sample = supabase.table('wbr_global_data').select('*').limit(3).execute()
    for row in sample.data:
        logger.info(f"  {row['date']}: ${row['daily_spend']} - {row['orders']} orders")
    
    logger.info("\nSample WBR Regional Data:")
    sample = supabase.table('wbr_regional_data').select('*').limit(3).execute()
    for row in sample.data:
        logger.info(f"  {row['date']} - {row['customer_type']} - {row['region']}: ${row['bookings']}")

def main():
    """Main import function"""
    logger.info("Starting EightSleep data import...")
    
    # Check if CSV files exist
    required_files = [
        'datasets/channel_performance.csv',
        'datasets/wbr_Global_data.csv',
        'datasets/wbr_regional_data.csv'
    ]
    
    for file_path in required_files:
        if not os.path.exists(file_path):
            logger.error(f"Missing required file: {file_path}")
            return
    
    try:
        # Create Supabase client
        supabase = create_supabase_client()
        
        # Import all datasets
        import_channel_performance(supabase)
        import_wbr_global_data(supabase)
        import_wbr_regional_data(supabase)
        
        # Verify import
        verify_import(supabase)
        
        logger.info("✅ Data import completed successfully!")
        
    except Exception as e:
        logger.error(f"❌ Import failed: {str(e)}")
        raise

if __name__ == "__main__":
    main()
