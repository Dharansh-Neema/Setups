sudo apt update 
sudo apt upgrade -y

sudo apt install -y openjdk-17-jdk
sudo apt install -y wget gnupg
wget -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins

sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
sudo source ~/.bashrc
sudo nvm install v22.14.0
sudo npm install -g npm@latest
sudo npm install -g pm2

sudo systemctl start jenkins
sudo systemctl enable jenkins