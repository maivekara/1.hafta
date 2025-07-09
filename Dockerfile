FROM python:3.9-slim

# Node.js kurulumu (sadece ihtiyacınız varsa)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl ca-certificates gnupg && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /usr/share/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Sadece PROD bağımlılıkları (requirements.txt)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Node.js bağımlılıkları (sadece ihtiyacınız varsa)
COPY package.json package-lock.json ./
RUN npm ci --only=production

# Uygulama kodunu kopyala
COPY . .

# Uygulamayı çalıştır (Python için)
CMD ["python", "app.py"]

# Veya Node.js için:
# CMD ["npm", "start"]
