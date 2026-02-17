const API_BASE = "http://127.0.0.1:5000/api";

let token = localStorage.getItem("token") || "";

/* ---------------- REGISTER ---------------- */
document.getElementById("registerBtn").addEventListener("click", registerUser);
document.getElementById("loginBtn").addEventListener("click", loginUser);
document.getElementById("uploadBtn").addEventListener("click", uploadPDF);

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
        showStatus(data.message || data.error, res.ok ? "lightgreen" : "red");

    } catch (error) {
        showStatus("Server error during registration", "red");
    }
}

/* ---------------- LOGIN ---------------- */
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

/* ---------------- UPLOAD PDF ---------------- */
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

    const formData = new FormData();
    formData.append("file", file);

    showStatus("Analyzing report...", "yellow");

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

/* ---------------- DISPLAY RESULT ---------------- */
function displayResult(data) {

    document.getElementById("resultBox").style.display = "block";

    document.getElementById("summary").innerText = data.summary;

    const issuesList = document.getElementById("issues");
    issuesList.innerHTML = "";

    data.detected_issues.forEach(issue => {
        const li = document.createElement("li");
        li.innerText = issue;
        issuesList.appendChild(li);
    });

    const risk = document.getElementById("risk");
    risk.innerText = data.risk_level;
    risk.className = "";

    if (data.risk_level === "High")
        risk.classList.add("risk-high");
    else if (data.risk_level === "Moderate")
        risk.classList.add("risk-moderate");
    else
        risk.classList.add("risk-low");
}

/* ---------------- STATUS ---------------- */
function showStatus(message, color) {
    const status = document.getElementById("status");
    status.innerText = message;
    status.style.color = color;
}