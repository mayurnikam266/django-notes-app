FROM python:3.9

WORKDIR /app/backend

# Copy requirements first for layer caching
COPY requirements.txt /app/backend/

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN pip install --no-cache-dir mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app/backend/

EXPOSE 8000

# Run Django app at container runtime, not build time
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
