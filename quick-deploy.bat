@echo off
title AI Medical Report Analyzer - Quick Deploy
color 0B

echo ========================================
echo   AI Medical Report Analyzer
echo   Quick Website Link Generator
echo ========================================
echo.

echo This will create your live website link automatically!
echo.
echo Requirements:
echo 1. Git installed
echo 2. Heroku CLI installed  
echo 3. Heroku account
echo 4. OpenAI API key
echo.

REM Quick check for required tools
git --version >nul 2>&1
if errorlevel 1 (
    echo [1/4] Installing Git...
    echo Please download and install Git from: https://git-scm.com
    start https://git-scm.com
    pause
)

heroku --version >nul 2>&1
if errorlevel 1 (
    echo [2/4] Installing Heroku CLI...
    echo Please download and install Heroku CLI from: https://devcenter.heroku.com/articles/heroku-cli
    start https://devcenter.heroku.com/articles/heroku-cli
    pause
)

REM Check login
heroku auth:whoami >nul 2>&1
if errorlevel 1 (
    echo [3/4] Please login to Heroku...
    heroku login
)

echo [4/4] Ready to deploy AI Medical Report Analyzer!
echo.
set /p confirm="Continue with deployment? (Y/N): "
if /i not "%confirm%"=="Y" (
    echo Deployment cancelled.
    pause
    exit /b 1
)

REM Run the main deployment script
echo.
echo Starting deployment process...
call deploy-website.bat
