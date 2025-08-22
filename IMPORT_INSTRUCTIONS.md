# 🚀 Quick Data Import for EightSleep Business Case

## Option 1: Python Script (Recommended)

### Step 1: Run the Setup Script
```bash
python3 setup_import.py
```

This will:
- Install required packages
- Ask for your Supabase anon key
- Run the data import automatically

### Step 2: Get Your Supabase Key
1. Go to: https://supabase.com/dashboard/project/lmokzxpktcchregvavna/settings/api
2. Copy the "anon public" key
3. Paste it when prompted

## Option 2: Manual Import

### Step 1: Install Requirements
```bash
pip install -r requirements.txt
```

### Step 2: Update the Script
Edit `import_data.py` and replace `YOUR_SUPABASE_ANON_KEY` with your actual key.

### Step 3: Run Import
```bash
python3 import_data.py
```

## What Gets Imported

✅ **Channel Performance**: 72 rows of marketing data
✅ **WBR Global Data**: 561 rows of daily business metrics  
✅ **WBR Regional Data**: 9,851 rows of regional breakdowns

## Expected Results

After successful import, you should see:
- Channel Performance: 72 rows
- WBR Global Data: 561 rows
- WBR Regional Data: 9,851 rows

## Troubleshooting

### Common Issues
- **Missing CSV files**: Ensure all files are in the `datasets/` folder
- **Invalid Supabase key**: Get the correct key from your project settings
- **Permission errors**: Make sure you have write access to the database

### Manual Verification
Check your Supabase dashboard:
1. Go to **Table Editor**
2. Check each table for data
3. Verify row counts match expected totals

## Next Steps

After successful import:
1. Connect Metabase to your Supabase database
2. Start building dashboards for your business case analysis
3. Use the connection details from the main README

---

**Need help?** The Python script will show detailed logs of what's happening during import.
