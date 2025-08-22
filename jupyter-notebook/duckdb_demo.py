#!/usr/bin/env python3
"""
DuckDB Demo Script for EightSleep Business Case
Shows how to use DuckDB for fast analytical queries
"""

import duckdb
import pandas as pd
import os

def main():
    print("🦆 DuckDB Demo for EightSleep Data")
    print("=" * 50)
    
    # Check if CSV files exist
    csv_files = [
        'channel_performance.csv',
        'wbr_Global_data.csv', 
        'wbr_regional_data.csv'
    ]
    
    missing_files = [f for f in csv_files if not os.path.exists(f)]
    if missing_files:
        print(f"❌ Missing CSV files: {missing_files}")
        print("Please make sure the CSV files are in the current directory")
        return
    
    # Create DuckDB connection
    con = duckdb.connect(':memory:')
    print("✅ Connected to DuckDB in-memory database")
    
    # Load data
    print("\n📊 Loading CSV data...")
    df_channel = pd.read_csv('channel_performance.csv')
    df_global = pd.read_csv('wbr_Global_data.csv')
    df_regional = pd.read_csv('wbr_regional_data.csv')
    
    print(f"   - Channel Performance: {len(df_channel)} records")
    print(f"   - Global WBR Data: {len(df_global)} records")
    print(f"   - Regional WBR Data: {len(df_regional)} records")
    
    # Clean data
    print("\n🧹 Cleaning data...")
    
    def clean_currency(df, col):
        if col in df.columns:
            df[col] = df[col].astype(str).str.replace('$', '').str.replace(',', '')
            df[col] = pd.to_numeric(df[col], errors='coerce')
        return df
    
    # Clean channel data
    df_channel = clean_currency(df_channel, 'Spend')
    df_channel = clean_currency(df_channel, 'Last Click Revenue')
    df_channel['Month'] = pd.to_datetime(df_channel['Month'])
    
    # Clean global data
    df_global = clean_currency(df_global, 'Daily Spend')
    df_global = clean_currency(df_global, 'Bookings')
    df_global['Date'] = pd.to_datetime(df_global['Date'])
    
    print("   ✅ Data cleaned successfully!")
    
    # Run some example queries
    print("\n🔍 Running analytical queries...")
    
    # Query 1: Channel summary
    print("\n1. Channel Performance Summary:")
    channel_summary = con.execute("""
        SELECT 
            Channel,
            COUNT(*) as months,
            AVG(Spend) as avg_spend,
            AVG(Visitors) as avg_visitors,
            AVG("Last Click Orders") as avg_orders,
            AVG("Last Click Revenue") as avg_revenue
        FROM df_channel 
        GROUP BY Channel
        ORDER BY avg_revenue DESC
    """).fetchdf()
    
    print(channel_summary.to_string(index=False))
    
    # Query 2: Monthly trends
    print("\n2. Monthly Trends:")
    monthly_trends = con.execute("""
        SELECT 
            strftime('%Y-%m', Month) as month,
            SUM(Spend) as total_spend,
            SUM("Last Click Revenue") as total_revenue,
            SUM(Visitors) as total_visitors
        FROM df_channel 
        GROUP BY strftime('%Y-%m', Month)
        ORDER BY month
        LIMIT 10
    """).fetchdf()
    
    print(monthly_trends.to_string(index=False))
    
    # Query 3: ROI analysis
    print("\n3. ROI Analysis by Channel:")
    roi_analysis = con.execute("""
        SELECT 
            Channel,
            SUM(Spend) as total_spend,
            SUM("Last Click Revenue") as total_revenue,
            ROUND((SUM("Last Click Revenue") - SUM(Spend)) / SUM(Spend) * 100, 2) as roi_percent
        FROM df_channel 
        WHERE Spend > 0
        GROUP BY Channel
        ORDER BY roi_percent DESC
    """).fetchdf()
    
    print(roi_analysis.to_string(index=False))
    
    # Query 4: Global daily metrics
    print("\n4. Global Daily Metrics (by month):")
    daily_metrics = con.execute("""
        SELECT 
            strftime('%Y-%m', Date) as month,
            ROUND(AVG("Daily Spend"), 2) as avg_daily_spend,
            ROUND(AVG(Orders), 2) as avg_daily_orders,
            ROUND(AVG(Bookings), 2) as avg_daily_bookings
        FROM df_global 
        GROUP BY strftime('%Y-%m', Date)
        ORDER BY month
        LIMIT 10
    """).fetchdf()
    
    print(daily_metrics.to_string(index=False))
    
    # Query 5: Regional summary
    print("\n5. Regional Summary:")
    regional_summary = con.execute("""
        SELECT 
            Region,
            "Customer Type",
            COUNT(*) as records,
            ROUND(AVG(Orders), 2) as avg_orders,
            ROUND(AVG(Units), 2) as avg_units
        FROM df_regional 
        GROUP BY Region, "Customer Type"
        ORDER BY Region, "Customer Type"
        LIMIT 15
    """).fetchdf()
    
    print(regional_summary.to_string(index=False))
    
    # Close connection
    con.close()
    print("\n🔒 DuckDB connection closed")
    
    print("\n🎯 Key Benefits of DuckDB:")
    print("   - 🚀 Fast in-memory analytical queries")
    print("   - 💾 No database setup required")
    print("   - 🔍 Standard SQL syntax")
    print("   - 📊 Seamless pandas integration")
    print("   - 📈 Built for analytical workloads")
    
    print("\n💡 Next Steps:")
    print("   - Run this script to see DuckDB in action")
    print("   - Open the DuckDB_Example.ipynb notebook for interactive analysis")
    print("   - Use ./quick-start.sh to start Jupyter for more exploration")

if __name__ == "__main__":
    main()
