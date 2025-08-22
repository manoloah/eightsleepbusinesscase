# Database Migrations for EightSleep Business Case

This folder contains all the SQL migration files needed to set up the database schema for the EightSleep business case analysis.

## 📊 Tables Created

### 1. `channel_performance` - Marketing Channel Analytics
**File**: `001_create_channel_performance_table.sql`

Stores marketing channel performance data including:
- Channel name (YouTube Ads, FB Ads, Google Ads, Organic + Direct)
- Monthly spend and visitor metrics
- Conversion data (add to cart, orders, revenue)
- Email capture and conversion metrics (30-day and 60-day windows)

**Key Metrics**:
- Spend analysis by channel
- Visitor-to-conversion funnel
- Email marketing effectiveness
- Channel ROI comparison

### 2. `wbr_global_data` - Daily Business Metrics
**File**: `002_create_wbr_global_data_table.sql`

Stores daily global business performance including:
- Daily spend and revenue
- Order volume and visitor count
- Daily business trends and patterns

**Key Metrics**:
- Daily revenue tracking
- Spend efficiency analysis
- Visitor-to-order conversion rates
- Business growth trends

### 3. `wbr_regional_data` - Regional Business Breakdown
**File**: `003_create_wbr_regional_data_table.sql`

Stores regional business metrics by customer type:
- Geographic breakdown (US, CA, GB, EU, AU, Other)
- Customer type segmentation
- Regional performance analysis

**Key Metrics**:
- Regional revenue distribution
- Customer type performance by region
- Market penetration analysis
- Geographic expansion opportunities

## 🚀 How to Apply Migrations

### Option 1: Using Supabase Dashboard (Recommended)
1. Go to your Supabase project dashboard
2. Navigate to **SQL Editor**
3. Copy and paste each migration file content
4. Execute them in order (001, 002, 003, 004)

### Option 2: Using Supabase CLI
```bash
# Apply migrations in order
supabase db reset
supabase db push
```

### Option 3: Using Metabase (After Connection)
1. Connect Metabase to your Supabase database
2. Use the **Native Query** feature
3. Execute each migration file

## 📥 Data Import

### File: `004_data_import_queries.sql`

This file contains:
- **CSV Import Queries**: For bulk data import from CSV files
- **Sample Data**: Test data to verify table structure
- **Data Validation**: Queries to verify successful import

### Import Methods

#### Method 1: Supabase Dashboard Import
1. Go to **Table Editor** in Supabase
2. Select the target table
3. Click **Import data**
4. Upload your CSV file
5. Map columns correctly
6. Import data

#### Method 2: CSV Upload + SQL Import
1. Upload CSV files to Supabase Storage
2. Use the provided SQL queries in `004_data_import_queries.sql`
3. Execute the import queries

#### Method 3: Manual Data Entry
Use the sample INSERT statements for testing and development.

## 🔍 Data Validation Queries

After importing data, run these queries to verify:

```sql
-- Check table row counts
SELECT 'channel_performance' as table_name, COUNT(*) as row_count FROM channel_performance
UNION ALL
SELECT 'wbr_global_data' as table_name, COUNT(*) as row_count FROM wbr_global_data
UNION ALL
SELECT 'wbr_regional_data' as table_name, COUNT(*) as row_count FROM wbr_regional_data;

-- Check data ranges
SELECT 
    MIN(month) as earliest_date,
    MAX(month) as latest_date,
    COUNT(DISTINCT channel) as unique_channels
FROM channel_performance;

-- Verify regional data
SELECT 
    region,
    COUNT(*) as records,
    MIN(date) as earliest_date,
    MAX(date) as latest_date
FROM wbr_regional_data
GROUP BY region;
```

## 📈 Business Case Analysis Queries

### Marketing Channel Performance
```sql
-- Channel ROI Analysis
SELECT 
    channel,
    SUM(spend) as total_spend,
    SUM(last_click_revenue) as total_revenue,
    (SUM(last_click_revenue) - SUM(spend)) / SUM(spend) * 100 as roi_percentage
FROM channel_performance
WHERE spend > 0
GROUP BY channel
ORDER BY roi_percentage DESC;
```

### Regional Performance
```sql
-- Regional Revenue Analysis
SELECT 
    region,
    SUM(bookings) as total_revenue,
    COUNT(*) as transaction_count,
    AVG(bookings) as avg_transaction_value
FROM wbr_regional_data
GROUP BY region
ORDER BY total_revenue DESC;
```

### Customer Type Analysis
```sql
-- Customer Type Performance
SELECT 
    customer_type,
    SUM(bookings) as total_revenue,
    SUM(orders) as total_orders,
    AVG(bookings) as avg_order_value
FROM wbr_regional_data
GROUP BY customer_type
ORDER BY total_revenue DESC;
```

## 🛠️ Troubleshooting

### Common Issues

#### Migration Errors
- Ensure you're connected to the correct database
- Check that the `update_updated_at_column()` function exists
- Verify table names don't conflict with existing tables

#### Data Import Issues
- Check CSV column headers match table columns
- Verify data types (dates, numbers, text)
- Handle NULL values appropriately
- Check for special characters in text fields

#### Performance Issues
- Indexes are automatically created for common query patterns
- Monitor query performance in Supabase dashboard
- Consider partitioning for large datasets

## 📚 Next Steps

1. **Apply Migrations**: Execute all migration files in order
2. **Import Data**: Use the data import queries or Supabase dashboard
3. **Verify Data**: Run validation queries to ensure data integrity
4. **Connect Metabase**: Follow the connection guide in the main README
5. **Create Dashboards**: Build visualizations for your business case analysis

## 🔗 Related Files

- **Main README**: Overall project setup and Metabase connection
- **Metabase Setup**: Detailed connection and configuration guide
- **Quick Start**: Immediate deployment instructions

---

**Ready to analyze EightSleep business data! 🎯**
