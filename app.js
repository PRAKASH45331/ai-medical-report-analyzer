/* ==========================================
   AI Medical Analyzer - Frontend JS
   Secure Production Version
========================================== */

const API_BASE = "http://127.0.0.1:5000/api";
// ⚠️ Change to your Render URL after deployment
// Example:
//const API_BASE = "https://ai-medical-analyzer-xyz1.onrender.com/api";

let token = localStorage.getItem("token") || "";

/* ================= INIT ================= */

document.addEventListener("DOMContentLoaded", () => {

    const registerBtn = document.getElementById("registerBtn");
    const loginBtn = document.getElementById("loginBtn");
    const uploadBtn = document.getElementById("uploadBtn");

    if (registerBtn) registerBtn.addEventListener("click", registerUser);
    if (loginBtn) loginBtn.addEventListener("click", loginUser);
    if (uploadBtn) uploadBtn.addEventListener("click", uploadPDF);

});

/* ================= REGISTER ================= */

async function registerUser() {

    const username = document.getElementById("regUser").value.trim();
    const password = document.getElementById("regPass").value.trim();

    if (!username || !password) {
        showStatus("Please enter username and password", "red");
        return;
    }

    try {
        const res = await fetch(`${API_BASE}/register`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ username, password })
        });

        const data = await res.json();

        showStatus(
            data.message || data.error || "Registration complete",
            res.ok ? "lightgreen" : "red"
        );

    } catch (error) {
        showStatus("Server error during registration", "red");
    }
}

/* ================= LOGIN ================= */

async function loginUser() {

    const username = document.getElementById("loginUser").value.trim();
    const password = document.getElementById("loginPass").value.trim();

    if (!username || !password) {
        showStatus("Please enter username and password", "red");
        return;
    }

    try {
        const res = await fetch(`${API_BASE}/login`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ username, password })
        });

        const data = await res.json();

        if (data.access_token) {
            token = data.access_token;
            localStorage.setItem("token", token);
            showStatus("Login Successful ✅", "lightgreen");
        } else {
            showStatus(data.error || "Login failed", "red");
        }

    } catch (error) {
        showStatus("Server error during login", "red");
    }
}

/* ================= UPLOAD PDF ================= */

async function uploadPDF() {

    if (!token) {
        showStatus("Please login first!", "red");
        return;
    }

    const fileInput = document.getElementById("pdfFile");
    const file = fileInput.files[0];

    if (!file) {
        showStatus("Please select a PDF file", "red");
        return;
    }

    if (file.type !== "application/pdf") {
        showStatus("Only PDF files are allowed", "red");
        return;
    }

    const formData = new FormData();
    formData.append("file", file);

    showStatus("Analyzing report... ⏳", "orange");

    try {
        const res = await fetch(`${API_BASE}/upload`, {
            method: "POST",
            headers: {
                "Authorization": "Bearer " + token
            },
            body: formData
        });

        const data = await res.json();

        if (!res.ok) {
            showStatus(data.error || "Upload failed", "red");
            return;
        }

        displayResult(data);
        showStatus("Analysis Complete ✅", "lightgreen");

    } catch (error) {
        showStatus("Server error during upload", "red");
    }
}

/* ================= DISPLAY RESULT ================= */

function displayResult(data) {

    const resultBox = document.getElementById("resultBox");
    if (!resultBox) return;

    resultBox.style.display = "block";

    const summary = document.getElementById("summary");
    summary.innerText = data.summary || "No summary available.";

    // Since backend returns formatted text, we safely display it.
    // (Your current backend does not return detected_issues array separately)

    const issuesList = document.getElementById("issues");
    if (issuesList) {
        issuesList.innerHTML = "";
    }

    const risk = document.getElementById("risk");
    if (risk) {
        risk.innerText = "See summary above";
        risk.className = "risk-moderate";
    }
}

/* ================= DOWNLOAD REPORT ================= */

async function downloadReport(reportId) {

    if (!token) {
        showStatus("Please login first!", "red");
        return;
    }

    try {
        const res = await fetch(`${API_BASE}/download/${reportId}`, {
            method: "GET",
            headers: {
                "Authorization": "Bearer " + token
            }
        });

        if (!res.ok) {
            showStatus("Download failed", "red");
            return;
        }

        const blob = await res.blob();
        const url = window.URL.createObjectURL(blob);

        const a = document.createElement("a");
        a.href = url;
        a.download = `medical_report_${reportId}.pdf`;
        document.body.appendChild(a);
        a.click();
        a.remove();

        showStatus("Download started ✅", "lightgreen");

    } catch (error) {
        showStatus("Download error", "red");
    }
}

/* ================= STATUS MESSAGE ================= */

function showStatus(message, color) {
    const status = document.getElementById("status");
    if (!status) return;

    status.innerText = message;
    status.style.color = color;
}