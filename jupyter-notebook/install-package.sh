#!/bin/bash

if [ $# -eq 0 ]; then
    echo "📦 Usage: ./install-package.sh package_name"
    echo "Example: ./install-package.sh scikit-learn"
    exit 1
fi

PACKAGE_NAME=$1

echo "📦 Installing $PACKAGE_NAME..."

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "❌ Virtual environment not found. Run ./setup.sh first!"
    exit 1
fi

# Activate virtual environment
source venv/bin/activate

# Install package
pip install $PACKAGE_NAME

# Update requirements.txt
echo "💾 Updating requirements.txt..."
pip freeze > requirements.txt

echo "✅ $PACKAGE_NAME installed successfully!"
echo "📝 requirements.txt updated"
echo ""
echo "🎯 You can now import $PACKAGE_NAME in your Jupyter notebook"
