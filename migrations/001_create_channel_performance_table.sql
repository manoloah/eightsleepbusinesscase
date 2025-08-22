-- Migration: Create channel_performance table
-- Description: Stores marketing channel performance data for EightSleep business case

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
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_channel_performance_updated_at 
    BEFORE UPDATE ON channel_performance 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();
