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

# Production bağımlılıkları
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Test bağımlılıkları (pytest) - CI için
COPY requirements-dev.txt .
RUN pip install --no-cache-dir -r requirements-dev.txt

# Node.js bağımlılıkları
COPY package.json package-lock.json ./
RUN npm ci --only=production

COPY . .

CMD ["python", "app.py"]
