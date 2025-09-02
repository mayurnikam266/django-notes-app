FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy requirements first (for caching)
COPY requirements.txt /app/backend

# Install system dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir mysqlclient \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY . /app/backend

# Expose Django default port
EXPOSE 8000

# Run Django app (not during build, but at container runtime)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
