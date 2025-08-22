#!/bin/bash

echo "🚀 Quick Starting EightSleep Jupyter Environment..."

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "❌ Virtual environment not found. Run ./setup.sh first!"
    exit 1
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Start Jupyter
echo "📊 Starting Jupyter Notebook..."
echo "🌐 Your notebook will open at: http://localhost:8888"
echo "🔑 Token will be displayed above"
echo ""
echo "💡 Press Ctrl+C to stop Jupyter"
echo ""

jupyter notebook --no-browser --port=8888
