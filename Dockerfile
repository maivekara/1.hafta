FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt  # varsa bağımlılıkların

CMD ["pytest"]  # veya "python", "-m", "unittest", "-v" ya da test komutun neyse

