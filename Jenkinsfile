def clientImage
def serverImage

pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = credentials('AWS_ACCOUNT_NAME')
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY_ID')
    }

    stages {
        stage ('1. Create  AWS infra using terraform') {
            steps {
                sh '''
                    cd ./infra
                    terraform init
                    terraform apply --auto-approve
                '''
            }
        }

        stage('2. Build docker image for client and server') {
            steps {
                    script {
                        clientImage = docker.build('client:latest', './client')
                        serverImage = docker.build('server:latest', './server')
                    }
            }
        }

        stage('3. Login into ECR') {
            steps {
                sh '''
                echo "Login into ECR"
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin \
                $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                '''
            }
        }

        stage('4. Tag and push docker image to ECR') {
            steps {
                sh '''
                    echo 'Tag and push docker image to ECR...'
                    ECR_REPO="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/web_ecs_image_repo"

                    docker tag client:latest ${ECR_REPO}:client_latest
                    docker tag server:latest ${ECR_REPO}:server_latest

                    docker push ${ECR_REPO}:client_latest
                    docker push ${ECR_REPO}:server_latest

                    '''
                }
            }

        stage('5. Finally refershing state of ECS') {
            steps {
                sh '''
                cd ./infra
                echo 'refreshing the infrastructure'
                terraform apply --auto-approve
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution complete...!!'
        }
    }
}