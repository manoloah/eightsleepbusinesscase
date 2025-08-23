# 🚀 EightSleep Jupyter Environment - Quick Start

## ✅ What's Already Set Up

- **DuckDB** ✅ Installed and ready to use
- **Virtual Environment** ✅ Created and configured
- **All Required Packages** ✅ Installed
- **Example Scripts** ✅ Ready to run

## 🎯 Get Started in 3 Steps

### 1. 🚀 Start Jupyter (Easiest Way)
```bash
./quick-start.sh
```
This will:
- Activate your virtual environment
- Start Jupyter notebook
- Open at http://localhost:8888

### 2. 🦆 Test DuckDB (Quick Demo)
```bash
./duckdb_demo.py
```
This will show you DuckDB in action with your data!

### 3. 📊 Open Your Notebook
- Navigate to `Data_exploration_8sleep_BC.ipynb`
- Add this cell to test DuckDB:
```python
import duckdb
print("✅ DuckDB is working!")
```

## 🔧 Install More Packages

```bash
./install-package.sh package_name
# Examples:
./install-package.sh scikit-learn
./install-package.sh streamlit
./install-package.sh dash
```

## 🐳 Start Local Database (Optional)

```bash
docker-compose -f docker-compose-local.yml up -d
```

## 💡 Pro Tips

1. **Always use the scripts** - They handle virtual environment activation
2. **DuckDB is perfect for CSV analysis** - No database setup needed
3. **Use `./quick-start.sh` every time** - It's the fastest way to get started
4. **Need a new package?** Use `./install-package.sh` - it updates requirements.txt automatically

## 🆘 Troubleshooting

- **Port 8888 busy?** Change it in `quick-start.sh`
- **Package not found?** Run `./setup.sh` again
- **Virtual environment issues?** Delete `venv/` folder and run `./setup.sh`

## 🎉 You're All Set!

Your environment is ready for:
- 📊 Data analysis with DuckDB
- 📈 Interactive visualizations
- 🔍 SQL queries on CSV data
- 📝 Jupyter notebooks
- 🐳 Local PostgreSQL database

**Happy analyzing! 🚀**
