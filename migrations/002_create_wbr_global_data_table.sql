-- Migration: Create wbr_global_data table
-- Description: Stores daily global business metrics for EightSleep business case

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
