-- Migration: Create wbr_regional_data table
-- Description: Stores regional business metrics by customer type for EightSleep business case

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
