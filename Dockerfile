FROM python:3.9-slim

# Sistem bağımlılıkları ve Node.js kurulumu
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Python bağımlılıkları
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Node.js bağımlılıkları (eğer package.json varsa)
COPY package*.json ./
RUN npm install

# Uygulama kodunu kopyala
COPY . .

CMD ["python", "app.py"]  # Veya npm komutuna göre güncelleyin
