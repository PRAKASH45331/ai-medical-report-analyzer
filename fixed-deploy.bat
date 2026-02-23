@echo off
title AI Medical Report Analyzer - Fixed Auto Deploy
color 0A

echo ========================================
echo   AI Medical Report Analyzer
echo   Fixed Auto Deploy to Vercel
echo ========================================
echo.

REM Update pip first
echo Updating pip...
python -m pip install --upgrade pip

REM Install requirements
echo Installing requirements...
pip install -r requirements.txt

if errorlevel 1 (
    echo ERROR: Failed to install requirements
    pause
    exit /b 1
)

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo Installing Node.js...
    start https://nodejs.org/en/download/
    echo Please install Node.js first, then run this script again.
    pause
    exit /b 1
)

REM Check if Vercel CLI is installed
vercel --version >nul 2>&1
if errorlevel 1 (
    echo Installing Vercel CLI...
    npm install -g vercel
    if errorlevel 1 (
        echo ERROR: Failed to install Vercel CLI
        pause
        exit /b 1
    )
)

REM Set environment variables
echo Setting environment variables...
set OPENAI_KEY=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

REM Create vercel.json if not exists
if not exist vercel.json (
    echo Creating vercel.json...
    echo {"version": 2, "builds": [{"src": "app.py", "use": "@vercel/python"}], "routes": [{"src": "/(.*)", "dest": "app.py"}], "env": {"PYTHON_VERSION": "3.9"}} > vercel.json
)

REM Deploy to Vercel
echo Deploying AI Medical Report Analyzer...
vercel --prod

if errorlevel 1 (
    echo ERROR: Deployment failed
    echo Trying alternative deployment method...
    vercel
)

echo.
echo ========================================
echo   DEPLOYMENT COMPLETE!
echo ========================================
echo.
echo Your AI Medical Report Analyzer is now live!
echo.
echo Check your Vercel dashboard for the website link.
echo.
echo Press any key to open Vercel dashboard...
pause >nul
start https://vercel.com/dashboard

echo.
echo ========================================
echo   SUCCESS!
echo ========================================
echo Your website is now online!
echo Share your website link with users.
pause
