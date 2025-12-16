#!/bin/bash

echo "🚀 Starting Deployment for Ganesha Operation Test..."

# 1. Buat Struktur Folder
mkdir -p html
mkdir -p certs
mkdir -p nginx

# 2. Generate Self-Signed SSL Certificate (Untuk HTTPS)
echo "🔒 Generating SSL Certificates..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout certs/server.key \
  -out certs/server.crt \
  -subj "/C=ID/ST=JawaTengah/L=Semarang/O=GaneshaOps/CN=localhost"

# 3. Buat Halaman Web Keren
echo "📝 Creating Index.html..."
cat <<EOF > html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Ganesha DevOps Test</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .card { background: white; padding: 40px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; max-width: 400px; }
        h1 { color: #007bff; margin-bottom: 10px; }
        .badge { background: #28a745; color: white; padding: 5px 10px; border-radius: 20px; font-size: 0.8em; font-weight: bold; }
        .info { color: #6c757d; margin-top: 20px; font-size: 0.9em; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Halo Ganesha Operation!</h1>
        <span class="badge">HTTPS SECURE</span>
        <p>Technical Test Submission</p>
        <hr>
        <div class="info">
            <p><strong>Candidate:</strong> Muhammad Najib Fauzan</p>
            <p><strong>Infrastructure:</strong> AWS (Code) + VPS (Demo)</p>
            <p><strong>Tech Stack:</strong> Docker Compose, Nginx, SSL</p>
        </div>
    </div>
</body>
</html>
EOF

# 4. Jalankan Docker Compose
echo "🐳 Starting Docker Containers..."
docker compose down # Matikan container lama jika ada
docker compose up -d

echo "✅ Deployment Success!"
echo "Try accessing: https://<YOUR-VPS-IP>"
echo "(Note: Browser will warn about self-signed cert, verify by clicking Advanced -> Proceed)"