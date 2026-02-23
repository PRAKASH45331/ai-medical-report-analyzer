@echo off
title AI Medical Report Analyzer - Auto Deploy
color 0A

echo ========================================
echo   AI Medical Report Analyzer
echo   Auto Deploy to Vercel
echo ========================================
echo.

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

REM Login to Vercel
echo Logging into Vercel...
vercel login

REM Set environment variables
echo Setting environment variables...
set OPENAI_KEY=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

REM Deploy to Vercel
echo Deploying AI Medical Report Analyzer...
vercel --prod

if errorlevel 1 (
    echo ERROR: Deployment failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo   DEPLOYMENT SUCCESSFUL!
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
echo   AUTO DEPLOY COMPLETE!
echo ========================================
pause
