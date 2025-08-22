# EightSleep Jupyter Environment

Quick setup and usage guide for the EightSleep business case analysis.

## 🚀 Quick Start

### 1. Initial Setup (First time only)
```bash
./setup.sh
```

### 2. Start Jupyter (Every time)
```bash
./quick-start.sh
```

### 3. Install Additional Packages
```bash
./install-package.sh package_name
# Example: ./install-package.sh scikit-learn
```

## 📦 What's Included

- **DuckDB** - Fast analytical database
- **Pandas** - Data manipulation
- **Jupyter** - Interactive notebooks
- **Plotly/Matplotlib/Seaborn** - Data visualization
- **SQLAlchemy** - Database connectivity
- **Supabase** - Cloud database client

## 🎯 Usage Examples

### Using DuckDB
```python
import duckdb
import pandas as pd

# Create a DuckDB connection
con = duckdb.connect(':memory:')  # In-memory database

# Load your CSV data
df = pd.read_csv('channel_performance.csv')

# Query with DuckDB
result = con.execute("""
    SELECT channel, AVG(spend) as avg_spend 
    FROM df 
    GROUP BY channel
""").fetchdf()

print(result)
```

### Using Local PostgreSQL
```python
from sqlalchemy import create_engine
import pandas as pd

# Connect to local database
engine = create_engine('postgresql://eightsleep_user:eightsleep_password@localhost:5433/eightsleep_local')

# Query data
df = pd.read_sql("SELECT * FROM channel_performance LIMIT 10", engine)
```

## 🐳 Local Database

Start the local PostgreSQL database:
```bash
docker-compose -f docker-compose-local.yml up -d
```

Access pgAdmin at: http://localhost:8080
- Email: admin@eightsleep.com
- Password: admin123

## 📁 File Structure

- `setup.sh` - Initial environment setup
- `quick-start.sh` - Start Jupyter quickly
- `install-package.sh` - Install new packages
- `requirements.txt` - Python dependencies
- `docker-compose-local.yml` - Local database setup
- `import_local_data.py` - Import data to local DB

## 💡 Tips

1. **Always activate the virtual environment first**: `source venv/bin/activate`
2. **Install packages with the script**: `./install-package.sh package_name`
3. **Update requirements**: The install script automatically updates requirements.txt
4. **Use DuckDB for fast analytics**: Great for CSV analysis without database setup
5. **Use local PostgreSQL for persistent data**: When you need to save and query data

## 🔧 Troubleshooting

- **Port conflicts**: Change port in `quick-start.sh` if 8888 is busy
- **Package not found**: Run `./setup.sh` again to reinstall all packages
- **Database connection issues**: Make sure Docker is running and database is started
