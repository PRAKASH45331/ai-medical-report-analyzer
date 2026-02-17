# =====================================================
# AI-Based Medical Report Analyzer - PRO VERSION FINAL
# Save AI Results + Generate PDF + Admin Dashboard
# AUTO ADMIN SETUP INCLUDED
# =====================================================

import os
import sqlite3
import datetime
from flask import Flask, request, jsonify, send_file
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash
import pdfplumber
from openai import OpenAI
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.units import inch
from reportlab.lib.pagesizes import A4

# ------------------------------------------
# CONFIG
# ------------------------------------------
app = Flask(__name__)
CORS(app)

app.config["JWT_SECRET_KEY"] = "super_secret_key_12345"
jwt = JWTManager(app)

UPLOAD_FOLDER = "uploads"
REPORT_FOLDER = "reports"
DATABASE = "database.db"

os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(REPORT_FOLDER, exist_ok=True)

# 🔴 CHANGE THIS USERNAME TO YOUR ADMIN USERNAME
DEFAULT_ADMIN_USERNAME = "admin"

# ------------------------------------------
# OPENAI CONFIG
# ------------------------------------------
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

if not OPENAI_API_KEY:
    print("⚠ OPENAI_API_KEY not set!")

client = OpenAI(api_key=OPENAI_API_KEY)

# ------------------------------------------
# DATABASE INIT + AUTO ADMIN SETUP
# ------------------------------------------
def init_db():
    with sqlite3.connect(DATABASE) as conn:
        conn.execute("""
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT UNIQUE,
                password TEXT,
                role TEXT DEFAULT 'user'
            )
        """)
        conn.execute("""
            CREATE TABLE IF NOT EXISTS reports (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT,
                summary TEXT,
                created_at TEXT
            )
        """)
        conn.commit()

        # ✅ AUTO CREATE ADMIN IF NOT EXISTS
        admin_user = conn.execute(
            "SELECT * FROM users WHERE username=?",
            (DEFAULT_ADMIN_USERNAME,)
        ).fetchone()

        if not admin_user:
            admin_password = generate_password_hash("admin123")
            conn.execute(
                "INSERT INTO users (username,password,role) VALUES (?,?,?)",
                (DEFAULT_ADMIN_USERNAME, admin_password, "admin")
            )
            conn.commit()
            print("✅ Default admin created → Username: admin | Password: admin123")

init_db()

# ------------------------------------------
# AI ANALYZER
# ------------------------------------------
def analyze_medical_text(text):

    if not text:
        return "No readable content found in report."

    prompt = f"""
    You are a professional medical AI assistant.
    Analyze this report and provide:

    1. Short Summary
    2. Detected Conditions
    3. Risk Level (Low, Moderate, High)

    Report:
    {text[:3000]}
    """

    try:
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[
                {"role": "system", "content": "You are a medical AI assistant."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.3
        )

        return response.choices[0].message.content

    except Exception as e:
        return f"AI Error: {str(e)}"

# ------------------------------------------
# REGISTER
# ------------------------------------------
@app.route("/api/register", methods=["POST"])
def register():
    data = request.get_json()

    if not data or not data.get("username") or not data.get("password"):
        return jsonify({"error": "Username & password required"}), 400

    hashed = generate_password_hash(data["password"])

    try:
        with sqlite3.connect(DATABASE) as conn:
            conn.execute(
                "INSERT INTO users (username,password,role) VALUES (?,?,?)",
                (data["username"], hashed, "user")
            )
            conn.commit()
        return jsonify({"message": "Registered successfully"})
    except sqlite3.IntegrityError:
        return jsonify({"error": "User already exists"}), 400

# ------------------------------------------
# LOGIN
# ------------------------------------------
@app.route("/api/login", methods=["POST"])
def login():
    data = request.get_json()

    if not data or not data.get("username") or not data.get("password"):
        return jsonify({"error": "Username & password required"}), 400

    with sqlite3.connect(DATABASE) as conn:
        user = conn.execute(
            "SELECT * FROM users WHERE username=?",
            (data["username"],)
        ).fetchone()

    if user and check_password_hash(user[2], data["password"]):
        token = create_access_token(identity=user[1])
        return jsonify({"access_token": token})

    return jsonify({"error": "Invalid login"}), 401

# ------------------------------------------
# UPLOAD + SAVE RESULT
# ------------------------------------------
@app.route("/api/upload", methods=["POST"])
@jwt_required()
def upload():

    if "file" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    username = get_jwt_identity()
    file = request.files["file"]

    if file.filename == "":
        return jsonify({"error": "No selected file"}), 400

    filepath = os.path.join(UPLOAD_FOLDER, file.filename)
    file.save(filepath)

    text = ""
    try:
        with pdfplumber.open(filepath) as pdf:
            for page in pdf.pages:
                page_text = page.extract_text()
                if page_text:
                    text += page_text
    except:
        os.remove(filepath)
        return jsonify({"error": "Invalid PDF"}), 400

    os.remove(filepath)

    ai_result = analyze_medical_text(text)

    created_at = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    with sqlite3.connect(DATABASE) as conn:
        conn.execute(
            "INSERT INTO reports (username,summary,created_at) VALUES (?,?,?)",
            (username, ai_result, created_at)
        )
        conn.commit()

    return jsonify({
        "message": "Report analyzed & saved",
        "summary": ai_result
    })

# ------------------------------------------
# DOWNLOAD PDF REPORT
# ------------------------------------------
@app.route("/api/download/<int:report_id>", methods=["GET"])
@jwt_required()
def download(report_id):

    with sqlite3.connect(DATABASE) as conn:
        report = conn.execute(
            "SELECT summary FROM reports WHERE id=?",
            (report_id,)
        ).fetchone()

    if not report:
        return jsonify({"error": "Report not found"}), 404

    file_path = os.path.join(REPORT_FOLDER, f"report_{report_id}.pdf")

    doc = SimpleDocTemplate(file_path, pagesize=A4)
    elements = []

    styles = getSampleStyleSheet()
    elements.append(Paragraph("AI Medical Report Analysis", styles["Title"]))
    elements.append(Spacer(1, 0.5 * inch))
    elements.append(Paragraph(report[0], styles["Normal"]))

    doc.build(elements)

    return send_file(file_path, as_attachment=True)

# ------------------------------------------
# ADMIN DASHBOARD
# ------------------------------------------
@app.route("/api/admin/reports", methods=["GET"])
@jwt_required()
def admin_reports():

    username = get_jwt_identity()

    with sqlite3.connect(DATABASE) as conn:
        user = conn.execute(
            "SELECT role FROM users WHERE username=?",
            (username,)
        ).fetchone()

        if not user or user[0] != "admin":
            return jsonify({"error": "Unauthorized"}), 403

        rows = conn.execute("SELECT * FROM reports").fetchall()

    reports = []
    for row in rows:
        reports.append({
            "id": row[0],
            "username": row[1],
            "summary": row[2],
            "created_at": row[3]
        })

    return jsonify({"reports": reports})

# ------------------------------------------
# RUN
# ------------------------------------------
if __name__ == "__main__":
    print("🚀 PRO AI Medical Analyzer Running...")
    print("👑 Default Admin → username: admin | password: admin123")
    app.run(debug=True)
