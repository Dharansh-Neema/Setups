sudo apt update -y
sudo apt install -y openjdk-17-jdk maven

sudo apt install -y wget gnupg
wget -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins

update-alternatives --config java

sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins