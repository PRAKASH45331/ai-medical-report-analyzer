#!/bin/bash

# AI Medical Report Analyzer - Auto-Run Script (Linux/Mac)

echo "========================================"
echo "   AI Medical Report Analyzer"
echo "========================================"
echo

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python3 is not installed"
    echo "Please install Python from https://python.org"
    exit 1
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "ERROR: pip3 is not installed"
    echo "Please install pip3"
    exit 1
fi

# Check if required packages are installed
echo "Checking dependencies..."
python3 -c "import flask, openai, pdfplumber, reportlab, flask_jwt_extended, flask_cors, dotenv" &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installing required packages..."
    pip3 install flask openai pdfplumber reportlab flask-jwt-extended flask-cors python-dotenv
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to install dependencies"
        exit 1
    fi
fi

# Check if .env file exists
if [ ! -f .env ]; then
    echo "Creating .env file..."
    echo "OPENAI_API_KEY=your-openai-api-key-here" > .env
    echo "JWT_SECRET_KEY=super_secret_key_12345" >> .env
    echo "EXTERNAL_API_TOKEN=" >> .env
    echo
    echo "IMPORTANT: Please edit .env file and add your OpenAI API key"
    echo
fi

# Check if API key is set
if grep -q "your-openai-api-key-here" .env; then
    echo "WARNING: OpenAI API key is not set in .env file"
    echo "Please edit .env file and replace 'your-openai-api-key-here' with your actual API key"
    echo
fi

echo "Starting AI Medical Report Analyzer..."
echo "Application will be available at: http://localhost:5000"
echo "Admin login: username: admin, password: admin123"
echo
echo "Press Ctrl+C to stop the server"
echo "========================================"
echo

python3 app.py
