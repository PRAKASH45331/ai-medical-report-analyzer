@echo off
title AI Medical Report Analyzer - Deploy Now
color 0A

echo ========================================
echo   AI Medical Report Analyzer
echo   Deploy to Vercel Now
echo ========================================
echo.

echo Your API Key is ready!
echo Opening Vercel to deploy your website...
echo.

REM Open Vercel website
start https://vercel.com

REM Show API key for easy copy
echo ========================================
echo   YOUR API KEY (Copy This):
echo ========================================
echo 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
echo ========================================
echo.

echo Steps to deploy:
echo 1. Login or create account on Vercel
echo 2. Click "New Project"
echo 3. Upload your project files from d:\hinata
echo 4. Set environment variables:
echo    - Name: OPENAI_API_KEY
echo    - Value: (copy the key above)
echo 5. Click Deploy
echo 6. Get your website link!
echo.

echo Opening deployment guide...
start VERCEL-DEPLOYMENT.md

echo.
echo ========================================
echo   READY TO DEPLOY!
echo ========================================
echo.
echo Your AI Medical Report Analyzer will be live at:
echo https://ai-medical-analyzer.vercel.app
echo.
echo Press any key to continue...
pause >nul
