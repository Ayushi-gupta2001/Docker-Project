# 🚀 E-Commerce Website Deployment using GitHub Actions, Terraform, Docker, AWS ECR & ECS

## 🛠️ Prerequisites

- AWS Account with required IAM permissions  
- Jenkins installed and running  
- GitHub repository with application code  

---

## 📋 Setup Instructions

### 1. Install Jenkins  
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