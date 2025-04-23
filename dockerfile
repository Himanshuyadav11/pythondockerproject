# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Prevent prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3 and pip
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      python3 \
      python3-pip \
 && rm -rf /var/lib/apt/lists/*

# Set a working directory
WORKDIR /app

# Copy only requirements first to leverage Docker cache
COPY requirements.txt .

# Upgrade pip and install Python dependencies
RUN pip3 install --no-cache-dir --upgrade pip \
 && pip3 install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port your app listens on
EXPOSE 8000

# Define the default command to run your app
# (Replace "app.py" with your actual entrypoint if different)
CMD ["python3", "app.py"]
