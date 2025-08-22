#!/usr/bin/env python3
"""
Simple setup script for EightSleep data import
"""

import os
import subprocess
import sys

def install_requirements():
    """Install required packages"""
    print("📦 Installing required packages...")
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])
        print("✅ Packages installed successfully!")
    except subprocess.CalledProcessError:
        print("❌ Failed to install packages. Please run: pip install -r requirements.txt")
        return False
    return True

def get_supabase_key():
    """Get Supabase key from user"""
    print("\n🔑 Supabase Setup")
    print("=" * 50)
    print("To get your Supabase anon key:")
    print("1. Go to: https://supabase.com/dashboard/project/lmokzxpktcchregvavna/settings/api")
    print("2. Copy the 'anon public' key")
    print("3. Paste it below\n")
    
    key = input("Enter your Supabase anon key: ").strip()
    
    if not key:
        print("❌ No key provided. Please run the script again.")
        return None
    
    # Update the import script with the key
    try:
        with open('import_data.py', 'r') as f:
            content = f.read()
        
        content = content.replace('YOUR_SUPABASE_ANON_KEY', key)
        
        with open('import_data.py', 'w') as f:
            f.write(content)
        
        print("✅ Supabase key configured!")
        return True
    except Exception as e:
        print(f"❌ Failed to update key: {e}")
        return False

def run_import():
    """Run the data import"""
    print("\n🚀 Running data import...")
    try:
        subprocess.check_call([sys.executable, "import_data.py"])
        print("✅ Import completed successfully!")
    except subprocess.CalledProcessError:
        print("❌ Import failed. Check the error messages above.")
        return False
    return True

def main():
    """Main setup function"""
    print("🎯 EightSleep Business Case - Data Import Setup")
    print("=" * 60)
    
    # Install requirements
    if not install_requirements():
        return
    
    # Get Supabase key
    if not get_supabase_key():
        return
    
    # Run import
    if not run_import():
        return
    
    print("\n🎉 Setup complete! Your data is now in Supabase.")
    print("You can now connect Metabase to analyze your EightSleep business case data!")

if __name__ == "__main__":
    main()
