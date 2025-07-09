FROM python:3.9-slim

WORKDIR /app

COPY . .

CMD ["pytest"]  # veya "python", "-m", "unittest", "-v" ya da test komutun neyse

