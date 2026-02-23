#!/bin/bash
echo "Starting AI Medical Report Analyzer..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "Creating .env file..."
    echo "OPENAI_API_KEY=your-openai-api-key-here" > .env
    echo "JWT_SECRET_KEY=super_secret_key_12345" >> .env
    echo "EXTERNAL_API_TOKEN=" >> .env
    echo "Please edit .env file and add your OpenAI API key"
    exit 1
fi

python3 app.py
