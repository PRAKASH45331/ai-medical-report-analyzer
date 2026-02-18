@echo off
title AI Medical Report Analyzer - Full Stack
color 0A

echo ========================================
echo   AI Medical Report Analyzer
echo   Full Stack Application
echo ========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python from https://python.org
    pause
    exit /b 1
)

REM Check if frontend directory exists
if not exist frontend (
    echo ERROR: Frontend directory not found
    echo Please ensure frontend files are in the frontend folder
    pause
    exit /b 1
)

REM Check if required packages are installed
echo Checking dependencies...
python -c "import flask, openai, pdfplumber, reportlab, flask_jwt_extended, flask_cors, dotenv" >nul 2>&1
if errorlevel 1 (
    echo Installing required packages...
    pip install flask openai pdfplumber reportlab flask-jwt-extended flask-cors python-dotenv
    if errorlevel 1 (
        echo ERROR: Failed to install dependencies
        pause
        exit /b 1
    )
)

REM Check if .env file exists
if not exist .env (
    echo Creating .env file...
    echo OPENAI_API_KEY=sk-your-actual-openai-api-key-here > .env
    echo JWT_SECRET_KEY=super_secret_key_12345 >> .env
    echo EXTERNAL_API_TOKEN= >> .env
    echo.
    echo IMPORTANT: Please edit .env file and add your OpenAI API key
    echo.
    pause
)

REM Check if API key is set
findstr /C:"sk-your-actual-openai-api-key-here" .env >nul
if not errorlevel 1 (
    echo WARNING: OpenAI API key is not set in .env file
    echo Please edit .env file and replace 'sk-your-actual-openai-api-key-here' with your actual API key
    echo.
)

echo Starting AI Medical Report Analyzer...
echo.
echo Frontend: http://localhost:5000
echo Backend API: http://localhost:5000/api
echo Admin login: username: admin, password: admin123
echo.
echo Features:
echo - Modern web interface with responsive design
echo - User authentication and registration
echo - PDF upload and AI analysis
echo - Admin dashboard
echo - Downloadable PDF reports
echo.
echo Press Ctrl+C to stop the server
echo ========================================
echo.

python app.py

pause
