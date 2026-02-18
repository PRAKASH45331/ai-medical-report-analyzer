# AI Medical Report Analyzer - Complete Auto-Run Setup

## 🚀 One-Click Auto-Run

### Windows Users:
1. **Double-click `autorun.bat`** - This will:
   - Check Python installation
   - Auto-install missing dependencies
   - Create `.env` file if needed
   - Start the application

### Linux/Mac Users:
1. **Run `chmod +x autorun.sh`** (once)
2. **Run `./autorun.sh`** - This will:
   - Check Python3 installation
   - Auto-install missing dependencies
   - Create `.env` file if needed
   - Start the application

## 📋 Setup Checklist

Before running, make sure to:
1. **Edit `.env` file** and add your OpenAI API key:
   ```
   OPENAI_API_KEY=sk-your-actual-api-key-here
   ```

2. **Install Python** if not already installed:
   - Windows: https://python.org
   - Linux: `sudo apt install python3 python3-pip`
   - Mac: `brew install python3`

## 🌐 Access the Application

- **URL**: http://localhost:5000
- **Admin Login**: username: `admin`, password: `admin123`

## ✨ Features

- 🤖 AI-powered medical report analysis
- 🔐 User authentication with JWT tokens
- 📄 PDF upload and processing
- 👑 Admin dashboard
- 📥 Downloadable PDF reports
- 🔄 Auto-dependency installation

## 🛠️ Troubleshooting

If you encounter issues:
1. Ensure Python is installed and in PATH
2. Check that your OpenAI API key is valid
3. Make sure port 5000 is not blocked by firewall

## 📁 File Structure

```
d:\hinata\
├── app.py              # Main application
├── .env                # Environment variables
├── autorun.bat         # Windows auto-run script
├── autorun.sh          # Linux/Mac auto-run script
├── start.bat           # Simple Windows starter
├── start.sh            # Simple Linux/Mac starter
├── uploads/            # Temporary file uploads
├── reports/            # Generated PDF reports
└── database.db         # SQLite database
```
