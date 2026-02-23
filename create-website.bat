@echo off
title AI Medical Report Analyzer - Create Website Link
color 0A

echo ========================================
echo   AI Medical Report Analyzer
echo   Creating Your Website Link
echo ========================================
echo.

REM Set your API key directly
set OPENAI_KEY=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

echo Using your API key to deploy...
echo.

REM Initialize Git if needed
if not exist .git (
    echo Initializing Git repository...
    git init
    git add .
    git commit -m "AI Medical Report Analyzer - Initial Deploy"
)

REM Create Heroku app
echo Creating AI Medical Report Analyzer website...
heroku create ai-medical-analyzer

if errorlevel 1 (
    echo App might exist, trying alternative name...
    heroku create ai-medical-report-%RANDOM%
)

REM Set environment variables
echo Setting up your API key...
heroku config:set OPENAI_API_KEY=%OPENAI_KEY%
heroku config:set JWT_SECRET_KEY=super_secret_key_12345

REM Deploy to Heroku
echo Deploying your website...
git push heroku main

if errorlevel 1 (
    echo Trying to push to existing branch...
    git push heroku master
)

if errorlevel 1 (
    echo ERROR: Deployment failed
    echo Please check your Heroku login and try again
    pause
    exit /b 1
)

REM Get website URL
echo.
echo ========================================
echo   YOUR WEBSITE IS LIVE!
echo ========================================
echo.

for /f "tokens=*" %%i in ('heroku apps:info -s ^| findstr "web_url"') do set APP_URL=%%i
set APP_URL=%APP_URL:web_url=%
set APP_URL=%APP_URL: =%

echo AI Medical Report Analyzer Website:
echo %APP_URL%
echo.
echo ========================================
echo   SUCCESS!
echo ========================================
echo.
echo Your website details:
echo Name: AI Medical Report Analyzer
echo URL: %APP_URL%
echo Features: AI Medical Analysis
echo Admin: admin / admin123
echo.
echo Press any key to open your website...
pause >nul
start %APP_URL%

echo.
echo Your website is now online!
echo Share this link: %APP_URL%
pause
