# AI Medical Report Analyzer

🏥 **AI-Powered Medical Report Analysis Platform**

A modern web application that uses artificial intelligence to analyze medical reports and provide intelligent insights.

## ✨ Features

- 🤖 **AI Analysis** - Powered by OpenAI GPT-4 for medical report analysis
- 📄 **PDF Processing** - Upload and extract text from medical PDFs
- 🔐 **User Authentication** - Secure login system with JWT tokens
- 📊 **Admin Dashboard** - Manage all user reports and data
- 📱 **Responsive Design** - Works on desktop, tablet, and mobile
- 📥 **PDF Reports** - Download professional PDF summaries

## 🚀 Quick Start

### Local Development
1. **Clone repository**
   ```bash
   git clone https://github.com/yourusername/ai-medical-analyzer.git
   cd ai-medical-analyzer
   ```

2. **Set up environment**
   ```bash
   # Edit .env with your OpenAI API key
   OPENAI_API_KEY=sk-your-actual-openai-api-key-here
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Run application**
   ```bash
   python app.py
   ```

5. **Access app**
   - URL: http://localhost:5000
   - Admin login: `admin` / `admin123`

## 🌐 Live Demo

**🔗 [AI Medical Report Analyzer - Live Demo](https://your-app-name.herokuapp.com)**

## 🛠️ Technology Stack

### Frontend
- **HTML5** - Modern semantic markup
- **Tailwind CSS** - Utility-first CSS framework
- **JavaScript (ES6+)** - Modern frontend logic
- **Axios** - HTTP client for API calls

### Backend
- **Flask** - Python web framework
- **SQLite** - Lightweight database
- **JWT** - Authentication tokens
- **OpenAI API** - AI-powered analysis
- **PDFPlumber** - PDF text extraction
- **ReportLab** - PDF generation

## 🚀 Deployment

### Heroku (Recommended)
```bash
# Install Heroku CLI and login
heroku create your-app-name
heroku config:set OPENAI_API_KEY=sk-your-key-here
git push heroku main
```

### Other Platforms
- PythonAnywhere
- Vercel
- Railway
- Render

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed instructions.

## 📋 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/register` | User registration |
| POST | `/api/login` | User authentication |
| POST | `/api/upload` | Upload and analyze PDF |
| GET | `/api/download/<id>` | Download PDF report |
| GET | `/api/admin/reports` | Admin dashboard (admin only) |

## ⚠️ Disclaimer

This application is for educational purposes only. Not a substitute for professional medical advice.

---

**Made with ❤️ using Python, Flask, and OpenAI**
