FROM python:3.9-slim

# Sistem bağımlılıkları (sadece gerçekten gerekli olanlar)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Önce requirements.txt'yi kopyala (cache için optimize)
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Sonra tüm uygulamayı kopyala
COPY . .

CMD ["python", "app.py"]
