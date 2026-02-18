@echo off
title AI Medical Report Analyzer - Auto Deploy
color 0A

echo ========================================
echo   AI Medical Report Analyzer
echo   Automatic Website Deployment
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

REM Check if Heroku CLI is installed
heroku --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Heroku CLI is not installed
    echo Please install Heroku CLI from https://devcenter.heroku.com/articles/heroku-cli
    pause
    exit /b 1
)

REM Check if user is logged in to Heroku
echo Checking Heroku login...
heroku auth:whoami >nul 2>&1
if errorlevel 1 (
    echo Please login to Heroku first:
    heroku login
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

REM Create Heroku app with specific name
echo Creating AI Medical Report Analyzer website...
heroku create ai-medical-analyzer

if errorlevel 1 (
    echo App might already exist, checking...
    heroku apps:info ai-medical-analyzer 2>nul
    if errorlevel 1 (
        echo Creating app with random name...
        heroku create ai-medical-analyzer-%RANDOM%
    )
)

REM Set environment variables
echo Setting environment variables...
set /p OPENAI_KEY="Enter your OpenAI API Key: "
if "%OPENAI_KEY%"=="" (
    echo ERROR: OpenAI API Key is required
    pause
    exit /b 1
)

heroku config:set OPENAI_API_KEY=%OPENAI_KEY%
heroku config:set JWT_SECRET_KEY=super_secret_key_%RANDOM%

REM Deploy to Heroku
echo Deploying AI Medical Report Analyzer to live website...
git push heroku main

if errorlevel 1 (
    echo ERROR: Deployment failed
    pause
    exit /b 1
)

REM Get the app URL
echo.
echo ========================================
echo   AI MEDICAL REPORT ANALYZER LIVE!
echo ========================================
echo.
for /f "tokens=*" %%i in ('heroku apps:info -s ^| findstr "web_url"') do set APP_URL=%%i
set APP_URL=%APP_URL:web_url=%
set APP_URL=%APP_URL: =%

echo Your AI Medical Report Analyzer website is now live at:
echo.
echo %APP_URL%
echo.
echo ========================================
echo WEBSITE DETAILS:
echo ========================================
echo Name: AI Medical Report Analyzer
echo URL: %APP_URL%
echo Features: Medical Report Analysis, AI Processing
echo Admin Login: admin / admin123
echo.
echo Press any key to open your website...
pause >nul
start %APP_URL%

echo.
echo ========================================
echo   DEPLOYMENT COMPLETE!
echo ========================================
echo Your AI Medical Report Analyzer is now online!
echo Share this link with users: %APP_URL%
pause
