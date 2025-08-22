-- Initialize local PostgreSQL database for EightSleep business case
-- This script creates the same schema as the Supabase database

-- Create the update_updated_at_column function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create channel_performance table
CREATE TABLE IF NOT EXISTS channel_performance (
    id SERIAL PRIMARY KEY,
    channel VARCHAR(100) NOT NULL,
    spend DECIMAL(15,2),
    month DATE NOT NULL,
    visitors INTEGER,
    last_click_add_to_cart INTEGER,
    last_click_orders INTEGER,
    last_click_revenue DECIMAL(15,2),
    last_click_email_captures INTEGER,
    email_capture_conversions_30_day INTEGER,
    email_capture_conversions_60_day INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_channel_performance_channel ON channel_performance(channel);
CREATE INDEX IF NOT EXISTS idx_channel_performance_month ON channel_performance(month);
CREATE INDEX IF NOT EXISTS idx_channel_performance_channel_month ON channel_performance(channel, month);

-- Add comments for documentation
COMMENT ON TABLE channel_performance IS 'Marketing channel performance data including spend, visitors, conversions, and revenue';
COMMENT ON COLUMN channel_performance.channel IS 'Marketing channel name (YouTube Ads, FB Ads, Google Ads, Organic + Direct)';
COMMENT ON COLUMN channel_performance.spend IS 'Monthly spend amount in USD';
COMMENT ON COLUMN channel_performance.month IS 'Month of the data';
COMMENT ON COLUMN channel_performance.visitors IS 'Number of visitors from this channel';
COMMENT ON COLUMN channel_performance.last_click_orders IS 'Number of orders attributed to this channel';
COMMENT ON COLUMN channel_performance.last_click_revenue IS 'Revenue attributed to this channel';
COMMENT ON COLUMN channel_performance.email_capture_conversions_30_day IS 'Email capture conversions within 30 days';
COMMENT ON COLUMN channel_performance.email_capture_conversions_60_day IS 'Email capture conversions within 60 days';

-- Create updated_at trigger
CREATE TRIGGER update_channel_performance_updated_at 
    BEFORE UPDATE ON channel_performance 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Create wbr_global_data table
CREATE TABLE IF NOT EXISTS wbr_global_data (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    daily_spend DECIMAL(15,2),
    orders INTEGER,
    bookings DECIMAL(15,2),
    visitors INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_wbr_global_data_date ON wbr_global_data(date);
CREATE INDEX IF NOT EXISTS idx_wbr_global_data_orders ON wbr_global_data(orders);
CREATE INDEX IF NOT EXISTS idx_wbr_global_data_bookings ON wbr_global_data(bookings);

-- Add comments for documentation
COMMENT ON TABLE wbr_global_data IS 'Daily global business metrics including spend, orders, bookings, and visitors';
COMMENT ON COLUMN wbr_global_data.date IS 'Date of the metrics';
COMMENT ON COLUMN wbr_global_data.daily_spend IS 'Daily spend amount in USD';
COMMENT ON COLUMN wbr_global_data.orders IS 'Number of orders for the day';
COMMENT ON COLUMN wbr_global_data.bookings IS 'Total bookings/revenue for the day in USD';
COMMENT ON COLUMN wbr_global_data.visitors IS 'Number of visitors for the day';

-- Create updated_at trigger
CREATE TRIGGER update_wbr_global_data_updated_at 
    BEFORE UPDATE ON wbr_global_data 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Create wbr_regional_data table
CREATE TABLE IF NOT EXISTS wbr_regional_data (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    customer_type VARCHAR(100) NOT NULL,
    region VARCHAR(10) NOT NULL,
    bookings DECIMAL(15,2),
    orders INTEGER,
    units INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_wbr_regional_data_date ON wbr_regional_data(date);
CREATE INDEX IF NOT EXISTS idx_wbr_regional_data_customer_type ON wbr_regional_data(customer_type);
CREATE INDEX IF NOT EXISTS idx_wbr_regional_data_region ON wbr_regional_data(region);
CREATE INDEX IF NOT EXISTS idx_wbr_regional_data_date_customer_type ON wbr_regional_data(date, customer_type);
CREATE INDEX IF NOT EXISTS idx_wbr_regional_data_date_region ON wbr_regional_data(date, region);

-- Add comments for documentation
COMMENT ON TABLE wbr_regional_data IS 'Regional business metrics broken down by customer type and region';
COMMENT ON COLUMN wbr_regional_data.date IS 'Date of the metrics';
COMMENT ON COLUMN wbr_regional_data.customer_type IS 'Customer type (New Members, Member Upgrades, Subscription Renewals, Exchanges)';
COMMENT ON COLUMN wbr_regional_data.region IS 'Geographic region (US, CA, GB, EU, AU, Other)';
COMMENT ON COLUMN wbr_regional_data.bookings IS 'Total bookings/revenue for the region and customer type in USD';
COMMENT ON COLUMN wbr_regional_data.orders IS 'Number of orders for the region and customer type';
COMMENT ON COLUMN wbr_regional_data.units IS 'Number of units sold for the region and customer type';

-- Create updated_at trigger
CREATE TRIGGER update_wbr_regional_data_updated_at 
    BEFORE UPDATE ON wbr_regional_data 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Grant permissions to the user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO eightsleep_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO eightsleep_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO eightsleep_user;
