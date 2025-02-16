#!/bin/bash

# Update system
echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y

# Install required dependencies
echo "Installing dependencies..."
sudo apt install -y curl wget unzip

# Install Docker
echo "Installing Docker..."
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Add user to Docker group (optional)
echo "Adding user to Docker group..."
sudo usermod -aG docker $USER

# Install Docker Compose
echo "Installing Docker Compose..."
sudo apt install -y docker-compose

# Create SonarQube directory
echo "Creating SonarQube directory..."
mkdir -p ~/sonarqube && cd ~/sonarqube

# Create docker-compose.yml
echo "Creating docker-compose.yml..."
cat <<EOF > docker-compose.yml
version: '3'
services:
  sonarqube:
    image: sonarqube:lts
    container_name: sonarqube
    restart: unless-stopped
    depends_on:
      - db
    ports:
      - "9000:9000"
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://db:5432/sonarqube
      SONAR_JDBC_USERNAME: sonar
      SONAR_JDBC_PASSWORD: sonar
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_logs:/opt/sonarqube/logs

  db:
    image: postgres:14
    container_name: sonarqube_db
    restart: unless-stopped
    environment:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: sonar
      POSTGRES_DB: sonarqube
    volumes:
      - postgresql_data:/var/lib/postgresql/data

volumes:
  sonarqube_data:
  sonarqube_logs:
  postgresql_data:
EOF

# Start SonarQube
echo "Starting SonarQube..."
docker-compose up -d

# Open firewall port 9000 (AWS security group should also allow this)
echo "Opening firewall for SonarQube..."
sudo ufw allow 9000/tcp || echo "UFW not installed, skipping..."

# Print Success Message
echo "✅ SonarQube installation complete!"
echo "🌐 Access SonarQube at: http://$(curl -s ifconfig.me):9000"
echo "🔑 Default Credentials - Username: admin | Password: admin"
