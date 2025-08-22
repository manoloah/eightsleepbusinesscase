-- Migration: Data Import Queries
-- Description: SQL queries to import CSV data into the created tables

-- Note: These queries assume you have the CSV files uploaded to Supabase Storage
-- or you can use the Supabase dashboard to import the data directly

-- 1. Import channel_performance data
-- You can use this query after uploading the CSV to Supabase Storage:
/*
INSERT INTO channel_performance (channel, spend, month, visitors, last_click_add_to_cart, last_click_orders, last_click_revenue, last_click_email_captures, email_capture_conversions_30_day, email_capture_conversions_60_day)
SELECT 
    channel,
    CASE 
        WHEN spend = '' OR spend IS NULL THEN NULL 
        ELSE REPLACE(REPLACE(spend, '$', ''), ',', '')::DECIMAL(15,2)
    END as spend,
    month::DATE,
    visitors::INTEGER,
    "last_click_add_to_cart"::INTEGER,
    "last_click_orders"::INTEGER,
    CASE 
        WHEN "last_click_revenue" = '' OR "last_click_revenue" IS NULL THEN NULL 
        ELSE REPLACE(REPLACE("last_click_revenue", '$', ''), ',', '')::DECIMAL(15,2)
    END as last_click_revenue,
    "last_click_email_captures"::INTEGER,
    "email_capture_conversions_30_day"::INTEGER,
    "email_capture_conversions_60_day"::INTEGER
FROM (
    SELECT * FROM read_csv_auto('path_to_your_channel_performance.csv')
);
*/

-- 2. Import wbr_global_data
-- You can use this query after uploading the CSV to Supabase Storage:
/*
INSERT INTO wbr_global_data (date, daily_spend, orders, bookings, visitors)
SELECT 
    date::DATE,
    CASE 
        WHEN "daily_spend" = '' OR "daily_spend" IS NULL THEN NULL 
        ELSE REPLACE(REPLACE("daily_spend", '$', ''), ',', '')::DECIMAL(15,2)
    END as daily_spend,
    orders::INTEGER,
    CASE 
        WHEN bookings = '' OR bookings IS NULL THEN NULL 
        ELSE REPLACE(REPLACE(bookings, '$', ''), ',', '')::DECIMAL(15,2)
    END as bookings,
    REPLACE(visitors, ',', '')::INTEGER as visitors
FROM (
    SELECT * FROM read_csv_auto('path_to_your_wbr_global_data.csv')
);
*/

-- 3. Import wbr_regional_data
-- You can use this query after uploading the CSV to Supabase Storage:
/*
INSERT INTO wbr_regional_data (date, customer_type, region, bookings, orders, units)
SELECT 
    date::DATE,
    "customer_type",
    region,
    CASE 
        WHEN bookings = '' OR bookings IS NULL THEN NULL 
        ELSE REPLACE(REPLACE(bookings, '$', ''), ',', '')::DECIMAL(15,2)
    END as bookings,
    orders::INTEGER,
    units::INTEGER
FROM (
    SELECT * FROM read_csv_auto('path_to_your_wbr_regional_data.csv')
);
*/

-- Alternative: Manual data insertion for testing
-- You can manually insert sample data using these INSERT statements:

-- Sample channel performance data
INSERT INTO channel_performance (channel, spend, month, visitors, last_click_add_to_cart, last_click_orders, last_click_revenue, last_click_email_captures, email_capture_conversions_30_day, email_capture_conversions_60_day) VALUES
('YouTube Ads', 811498.00, '2025-05-01', 1275720, 2336, 313, 1738865.00, 37665, 247, 370),
('FB Ads', 246595.00, '2025-06-01', 633724, 44, 143, 697405.00, 12090, 34, 52),
('Google Ads', 860104.00, '2025-05-01', 216354, 1409, 860, 3930222.00, 14434, 602, 941);

-- Sample global data
INSERT INTO wbr_global_data (date, daily_spend, orders, bookings, visitors) VALUES
('2024-01-01', 34651.00, 96, 282147.00, 20075),
('2024-01-02', 37538.00, 82, 252338.00, 21069),
('2024-01-03', 35344.00, 69, 211774.00, 21845);

-- Sample regional data
INSERT INTO wbr_regional_data (date, customer_type, region, bookings, orders, units) VALUES
('2024-01-01', '1. New Members', 'US', 227892.00, 82, 83),
('2024-01-01', '1. New Members', 'CA', 15286.00, 6, 6),
('2024-01-01', '2. Member Upgrades', 'US', 4990.00, 2, 2);

-- Verify data insertion
SELECT 'channel_performance' as table_name, COUNT(*) as row_count FROM channel_performance
UNION ALL
SELECT 'wbr_global_data' as table_name, COUNT(*) as row_count FROM wbr_global_data
UNION ALL
SELECT 'wbr_regional_data' as table_name, COUNT(*) as row_count FROM wbr_regional_data;
