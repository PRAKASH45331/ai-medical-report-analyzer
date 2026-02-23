# AI Medical Report Analyzer - Web Deployment Guide

## 🌐 Deploy Your Project Online

### Option 1: Heroku (Free Tier)

1. **Install Heroku CLI**
   ```bash
   # Windows
   # Download from https://devcenter.heroku.com/articles/heroku-cli

   # Mac
   brew tap heroku/brew && brew install heroku

   # Linux
   sudo snap install heroku --classic
   ```

2. **Login to Heroku**
   ```bash
   heroku login
   ```

3. **Initialize Git Repository**
   ```bash
   git init
   git add .
   git commit -m "Initial AI Medical Report Analyzer"
   ```

4. **Create Heroku App**
   ```bash
   heroku create your-app-name
   ```

5. **Set Environment Variables**
   ```bash
   heroku config:set OPENAI_API_KEY=your_actual_openai_api_key
   heroku config:set JWT_SECRET_KEY=your_custom_secret_key
   ```

6. **Deploy to Heroku**
   ```bash
   git push heroku main
   ```

7. **Access Your App**
   ```
   https://your-app-name.herokuapp.com
   ```

### Option 2: PythonAnywhere (Free Tier)

1. **Sign Up**
   - Go to https://www.pythonanywhere.com
   - Create a free account

2. **Create Web App**
   - Dashboard → Web → Add a new web app
   - Choose Flask framework
   - Python 3.9+

3. **Upload Files**
   - Use Files tab to upload your project
   - Or use git: `git clone https://github.com/yourusername/yourrepo`

4. **Set Environment Variables**
   - In WSGI configuration file, add:
   ```python
   import os
   os.environ['OPENAI_API_KEY'] = 'your_actual_openai_api_key'
   os.environ['JWT_SECRET_KEY'] = 'your_custom_secret_key'
   ```

5. **Reload Web App**
   - Click "Reload" button

### Option 3: Vercel (Free Tier)

1. **Install Vercel CLI**
   ```bash
   npm i -g vercel
   ```

2. **Create vercel.json**
   ```json
   {
     "version": 2,
     "builds": [
       {
         "src": "app.py",
         "use": "@vercel/python"
       }
     ],
     "routes": [
       {
         "src": "/(.*)",
         "dest": "app.py"
       }
     ]
   }
   ```

3. **Deploy**
   ```bash
   vercel --prod
   ```

### Option 4: Railway (Free Tier)

1. **Install Railway CLI**
   ```bash
   npm install -g @railway/cli
   ```

2. **Login**
   ```bash
   railway login
   ```

3. **Deploy**
   ```bash
   railway up
   ```

4. **Set Environment Variables**
   - Go to Railway dashboard
   - Your project → Variables
   - Add OPENAI_API_KEY and JWT_SECRET_KEY

### Option 5: Render (Free Tier)

1. **Sign Up**
   - Go to https://render.com
   - Create free account

2. **Create Web Service**
   - New → Web Service
   - Connect GitHub repository
   - Set build command: `pip install -r requirements.txt`
   - Set start command: `gunicorn app:app`

3. **Environment Variables**
   - Add OPENAI_API_KEY and JWT_SECRET_KEY

## 📋 Pre-Deployment Checklist

### ✅ Required Files:
- `app.py` - Main Flask application
- `requirements.txt` - Python dependencies
- `Procfile` - Heroku deployment config
- `.env` - Environment variables (don't commit to git)
- `frontend/` folder with HTML/JS files

### ✅ Environment Variables:
- `OPENAI_API_KEY` - Your OpenAI API key
- `JWT_SECRET_KEY` - Custom secret for JWT tokens

### ✅ Git Repository Setup:
```bash
# Create .gitignore
echo "*.pyc
__pycache__/
.env
database.db
uploads/
reports/" > .gitignore

# Initialize and push
git init
git add .
git commit -m "AI Medical Report Analyzer"
git branch -M main
```

## 🚀 Quick Deploy Commands

### Heroku (Recommended):
```bash
heroku create ai-medical-analyzer
heroku config:set OPENAI_API_KEY=sk-your-key-here
git push heroku main
```

### Railway:
```bash
railway login
railway up
```

## 🌍 Your Live Website

Once deployed, your AI Medical Report Analyzer will be available at:
- **Heroku:** `https://your-app-name.herokuapp.com`
- **PythonAnywhere:** `yourusername.pythonanywhere.com`
- **Vercel:** `https://your-project.vercel.app`
- **Railway:** `https://your-app.up.railway.app`
- **Render:** `https://your-app.onrender.com`

## 💡 Pro Tips

1. **Custom Domain:** Most platforms support custom domains
2. **SSL Certificate:** All platforms provide free HTTPS
3. **Database:** For production, consider PostgreSQL instead of SQLite
4. **Monitoring:** Set up error tracking with Sentry
5. **Backup:** Regular database backups for production

## 🔧 Troubleshooting

**Common Issues:**
- **Application Error:** Check logs for missing dependencies
- **Environment Variables:** Ensure they're set correctly
- **Database Issues:** Some platforms don't support SQLite
- **File Upload:** Check platform file size limits

**Debug Commands:**
```bash
# Heroku
heroku logs --tail

# Railway
railway logs

# Render
# Check dashboard logs
```

Your AI Medical Report Analyzer is ready for global deployment! 🎉
