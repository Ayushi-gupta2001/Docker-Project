## E-COMMERCE WEBSITE application using GITHUB ACTIONS, Terraform, Docker and AWS ECR, ECS


### Pre-requisite

1. AWS Account 
2. Docker Hub Account 


#######

### Steps:

1. Installtion of Docker

    ```
    sudo apt update
    sudo apt upgrade -y

    sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo usermod -aG docker $USER

    sudo systemctl start docker

    **Test the docker by running command:
    docker run hello-world
    docker --version

    ```

  2. Clone the Repo