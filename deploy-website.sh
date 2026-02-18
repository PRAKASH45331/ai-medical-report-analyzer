#!/bin/bash

# AI Medical Report Analyzer - Auto Deploy Script (Linux/Mac)

echo "========================================"
echo "   AI Medical Report Analyzer"
echo "   Automatic Website Deployment"
echo "========================================"
echo

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "ERROR: Git is not installed"
    echo "Please install Git from https://git-scm.com"
    exit 1
fi

# Check if Heroku CLI is installed
if ! command -v heroku &> /dev/null; then
    echo "ERROR: Heroku CLI is not installed"
    echo "Please install Heroku CLI from https://devcenter.heroku.com/articles/heroku-cli"
    exit 1
fi

# Check if user is logged in to Heroku
echo "Checking Heroku login..."
if ! heroku auth:whoami &> /dev/null; then
    echo "Please login to Heroku first:"
    heroku login
    exit 1
fi

# Initialize Git repository if not already done
if [ ! -d ".git" ]; then
    echo "Initializing Git repository..."
    git init
    git add .
    git commit -m "Initial AI Medical Report Analyzer"
fi

# Check if Heroku app already exists
echo "Checking for existing Heroku app..."
if ! heroku apps:info &> /dev/null; then
    echo "Creating new Heroku app..."
    heroku create ai-medical-analyzer-$(date +%s | tail -c 6)
else
    echo "Using existing Heroku app..."
fi

# Set environment variables
echo "Setting environment variables..."
read -p "Enter your OpenAI API Key: " OPENAI_KEY
if [ -z "$OPENAI_KEY" ]; then
    echo "ERROR: OpenAI API Key is required"
    exit 1
fi

heroku config:set OPENAI_API_KEY="$OPENAI_KEY"
heroku config:set JWT_SECRET_KEY="super_secret_key_$RANDOM"

# Deploy to Heroku
echo "Deploying to Heroku..."
git push heroku main

if [ $? -ne 0 ]; then
    echo "ERROR: Deployment failed"
    exit 1
fi

# Get the app URL
echo
echo "========================================"
echo "   DEPLOYMENT SUCCESSFUL!"
echo "========================================"
echo

APP_URL=$(heroku apps:info -s | grep web_url | cut -d= -f2)
echo "Your website is now live at:"
echo "$APP_URL"
echo
echo "Admin Login:"
echo "Username: admin"
echo "Password: admin123"
echo
echo "Press Enter to open your website in browser..."
read -p ""

# Open the website in default browser
if command -v xdg-open &> /dev/null; then
    xdg-open "$APP_URL"
elif command -v open &> /dev/null; then
    open "$APP_URL"
elif command -v start &> /dev/null; then
    start "$APP_URL"
else
    echo "Please manually open: $APP_URL"
fi

echo
echo "========================================"
echo "   Deployment Complete!"
echo "========================================"
