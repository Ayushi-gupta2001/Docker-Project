# 🚀 E-Commerce Website Deployment using GitHub Actions, Terraform, Docker, AWS ECR & ECS

## 🛠️ Prerequisites

- AWS Account with required IAM permissions  
- Jenkins installed and running  
- GitHub repository with application code  

---

## 📋 Setup Instructions

### 1. Install Jenkins  

- Run the following commands on your Ubuntu-based system:
```bash
    1. sudo apt update && sudo apt upgrade -y
    2. sudo apt install -y fontconfig openjdk-17-jre
    3. java -version
    4. wget -O - https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    5. echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    6. sudo apt update
    7. sudo apt install -y jenkins
    8. sudo systemctl enable --now jenkins
    9. sudo systemctl status jenkins
```

- Launch Jenkins on your server or local machine:  
  - Remote: `http://<your-ip>:8080`  
  - Local: `http://localhost:8080`

### 2. Create Jenkins Pipeline  
- Open Jenkins UI and create a new pipeline job.

### 3. Configure AWS Credentials  
- Create an IAM user with programmatic access.  
- Add the credentials securely to Jenkins using **Credentials Manager**.

### 4. Connect GitHub Repository  
- Set your GitHub repository URL in the pipeline configuration.  
- Enable **Poll SCM** with this schedule:  

(checks for updates every minute)

### 5. Trigger the Pipeline  
- Clone the repository locally.  
- Make changes and push to GitHub.  
- Jenkins will auto-trigger the pipeline.

### 6. Access the Deployed Application  
- After deployment, access your app via:  
  `http://load-balancer-dns-name:8080`