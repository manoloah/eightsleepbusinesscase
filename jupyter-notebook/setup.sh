#!/bin/bash

echo "🚀 Setting up EightSleep Jupyter Environment..."

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
echo "⬆️  Upgrading pip..."
pip install --upgrade pip

# Install requirements
echo "📚 Installing packages from requirements.txt..."
pip install -r requirements.txt

# Install additional useful packages
echo "➕ Installing additional useful packages..."
pip install ipywidgets jupyterlab

echo "✅ Setup complete!"
echo ""
echo "🎯 To start Jupyter:"
echo "   source venv/bin/activate"
echo "   jupyter notebook"
echo ""
echo "🔧 To install more packages:"
echo "   source venv/bin/activate"
echo "   pip install package_name"
echo "   pip freeze > requirements.txt  # Save new packages"
echo ""
echo "🐳 To start local database:"
echo "   docker-compose -f docker-compose-local.yml up -d"
