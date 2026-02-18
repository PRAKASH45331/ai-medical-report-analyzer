# AI Medical Report Analyzer - Full Stack Application

## 🚀 Complete Frontend + Backend Auto-Run

### Quick Start

#### Windows Users:
1. **Double-click `run-fullstack.bat`** - This will:
   - Check Python installation
   - Auto-install missing dependencies
   - Verify frontend files exist
   - Create `.env` file if needed
   - Start the full-stack application

#### Linux/Mac Users:
1. **Run `chmod +x run-fullstack.sh`** (once)
2. **Run `./run-fullstack.sh`** - This will:
   - Check Python3 installation
   - Auto-install missing dependencies
   - Verify frontend files exist
   - Create `.env` file if needed
   - Start the full-stack application

## 🌐 Application Features

### Frontend (Modern Web Interface)
- **Responsive Design** - Works on desktop, tablet, and mobile
- **User Authentication** - Login and registration system
- **File Upload** - Drag-and-drop PDF upload interface
- **Real-time Analysis** - AI-powered medical report analysis
- **Results Display** - Beautiful presentation of analysis results
- **Download Reports** - Generate and download PDF reports
- **Admin Dashboard** - Manage all user reports

### Backend (Flask API)
- **RESTful API** - Clean API endpoints
- **JWT Authentication** - Secure user sessions
- **AI Integration** - OpenAI GPT-4 for medical analysis
- **Database** - SQLite for user and report storage
- **File Processing** - PDF text extraction
- **PDF Generation** - ReportLab for downloadable reports

## 📋 Setup Instructions

### 1. Environment Setup
Edit `.env` file and add your OpenAI API key:
```env
OPENAI_API_KEY=sk-your-actual-openai-api-key-here
JWT_SECRET_KEY=your-custom-secret-key
EXTERNAL_API_TOKEN=your-external-token-if-needed
```

### 2. Run the Application
- **Windows:** Double-click `run-fullstack.bat`
- **Linux/Mac:** `./run-fullstack.sh`

### 3. Access the Application
- **URL:** http://localhost:5000
- **Admin Login:** username: `admin`, password: `admin123`

## 🏗️ Project Structure

```
d:\hinata\
├── app.py                 # Flask backend application
├── frontend/              # Frontend files
│   ├── index.html        # Main HTML page
│   └── app.js            # JavaScript frontend logic
├── run-fullstack.bat      # Windows auto-run script
├── run-fullstack.sh       # Linux/Mac auto-run script
├── .env                   # Environment variables
├── uploads/               # Temporary file uploads
├── reports/               # Generated PDF reports
└── database.db            # SQLite database
```

## 🎯 API Endpoints

- `GET /` - Serve frontend
- `POST /api/register` - User registration
- `POST /api/login` - User login
- `POST /api/upload` - Upload and analyze PDF
- `GET /api/download/<id>` - Download PDF report
- `GET /api/admin/reports` - Admin dashboard (admin only)

## 🔧 Technology Stack

### Frontend
- **HTML5** - Modern semantic markup
- **Tailwind CSS** - Utility-first CSS framework
- **JavaScript (ES6+)** - Modern JavaScript features
- **Axios** - HTTP client for API calls

### Backend
- **Flask** - Python web framework
- **Flask-JWT-Extended** - JWT authentication
- **Flask-CORS** - Cross-origin resource sharing
- **SQLite** - Lightweight database
- **OpenAI API** - AI-powered analysis
- **PDFPlumber** - PDF text extraction
- **ReportLab** - PDF generation

## 🚀 Features Overview

1. **User Management**
   - User registration and login
   - JWT-based authentication
   - Admin user management

2. **File Processing**
   - PDF upload with drag-and-drop
   - Text extraction from PDFs
   - File validation and security

3. **AI Analysis**
   - OpenAI GPT-4 integration
   - Medical report analysis
   - Structured output format

4. **Report Generation**
   - PDF report creation
   - Download functionality
   - Professional formatting

5. **Admin Features**
   - View all user reports
   - Download any report
   - User management

## 🔒 Security Features

- JWT token authentication
- Password hashing with Werkzeug
- File upload validation
- CORS protection
- SQL injection prevention
- Input sanitization

## 📱 Responsive Design

- Mobile-first approach
- Touch-friendly interface
- Adaptive layouts
- Cross-browser compatibility

The AI Medical Report Analyzer is now a complete full-stack application with modern frontend and robust backend! 🎉
