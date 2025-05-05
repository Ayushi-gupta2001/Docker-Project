def clientImage
def serverImage
pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '23445'
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY_ID')
        CLIENT_IMAGE_NAME = 'client_image'
        CLIENT_IMAGE_TAG = 'latest'
        SERVER_IMAGE_NAME = 'server_image'
        SERVER_IMAGE_TAG = 'latest'
    }

    stages {
        stage('1. Build docker image for client and server') {
            steps {
                script {
                    clientImage = docker.build("${CLIENT_IMAGE_NAME}:${CLIENT_IMAGE_TAG}", './client')
                    serverImage = docker.build("${SERVER_IMAGE_NAME}:${SERVER_IMAGE_TAG}", './server')
                }
            }
        }

        stage('2. Create ECR repo into AWS using terraform') {
            steps {
                sh '''
                cd ./infra
                terraform init
                terraform apply -target=module.web_ecr_image --auto-approve
                '''
            }
        }

        stage('3. Login into ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin \
                $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                '''
            }
        }

        stage('4. Tag and push docker image to ECR') {
            steps {
                script {

                    def ecrClientImageName = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${CLIENT_IMAGE_NAME}:${CLIENT_IMAGE_NAME_TAG}"
                    def ecrServerImageName = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${SERVER_IMAGE_NAME}:${SERVER_IMAGE_NAME_TAG}"

                    clientImage.tag(ecrClientImageName)
                    serverImage.tag(ecrServerImageName)

                    clientImage.push(ecrClientImageName)
                    serverImage.push(ecrServerImageName)
                }

            }
        }

        stage('5. Provision the infra for ECS cluster') {
            steps {
                sh '''
                cd ./infra
                terraform init
                terraform apply --auto-approve
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution complete'
        }
    }

}