@echo off
title AI Medical Report Analyzer - Railway Deploy
color 0A

echo ========================================
echo   AI Medical Report Analyzer
echo   Railway Auto Deployment
echo ========================================
echo.

REM Check if Git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed
    echo Please install Git from https://git-scm.com
    pause
    exit /b 1
)

REM Check if Railway CLI is installed
railway --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Railway CLI is not installed
    echo Installing Railway CLI...
    npm install -g @railway/cli
    if errorlevel 1 (
        echo ERROR: Failed to install Railway CLI
        echo Please install Node.js from https://nodejs.org first
        pause
        exit /b 1
    )
)

REM Check if user is logged in to Railway
echo Checking Railway login...
railway status 2>nul | findstr "Logged in" >nul
if errorlevel 1 (
    echo Please login to Railway first:
    railway login
    pause
    exit /b 1
)

REM Initialize Git repository if not already done
if not exist .git (
    echo Initializing Git repository...
    git init
    git add .
    git commit -m "Initial AI Medical Report Analyzer"
)

REM Set environment variables
echo Setting environment variables...
set /p OPENAI_KEY="Enter your OpenAI API Key: "
if "%OPENAI_KEY%"=="" (
    echo ERROR: OpenAI API Key is required
    pause
    exit /b 1
)

REM Create railway.json for deployment
echo { > railway.json
echo   "build": { >> railway.json
echo     "builder": "NIXPACKS" >> railway.json
echo   }, >> railway.json
echo   "deploy": { >> railway.json
echo     "startCommand": "gunicorn app:app", >> railway.json
echo     "restartPolicyType": "ON_FAILURE", >> railway.json
echo     "restartPolicyMaxRetries": 10 >> railway.json
echo   } >> railway.json
echo } >> railway.json

REM Deploy to Railway
echo Deploying to Railway...
railway up

if errorlevel 1 (
    echo ERROR: Deployment failed
    pause
    exit /b 1
)

REM Set environment variables in Railway
echo Setting environment variables in Railway...
railway variables set OPENAI_API_KEY=%OPENAI_KEY%
railway variables set JWT_SECRET_KEY=super_secret_key_%RANDOM%

REM Get the app URL
echo.
echo ========================================
echo   DEPLOYMENT SUCCESSFUL!
echo ========================================
echo.
echo Your website is deploying...
echo.
echo To get your website URL:
echo 1. Go to https://railway.app
echo 2. Open your project
echo 3. Click on your service
echo 4. Copy the URL from the top
echo.
echo Admin Login:
echo Username: admin
echo Password: admin123
echo.
echo Railway provides:
echo - Free SSL certificate
echo - Automatic HTTPS
echo - Custom domain support
echo - Git-based deployment
echo.
pause
