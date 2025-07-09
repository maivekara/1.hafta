# Python ve Node.js'i bir arada içeren resmi imaj
FROM python:3.9-slim

# Node.js kurulumu (LTS sürümü)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl ca-certificates gnupg && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /usr/share/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Çalışma dizini
WORKDIR /app

# Önce Python bağımlılıkları
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Sonra Node.js bağımlılıkları
COPY package.json package-lock.json ./
RUN npm ci --only=production

# Uygulama kodunu kopyala
COPY . .

# HANGİSİNİ KULLANIYORSANIZ:
# Eğer Python uygulaması ise:
CMD ["python", "app.py"]

# Eğer Node.js uygulaması ise:
# CMD ["npm", "start"]
