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
        stage('1. Build docker image for client and server') {
            steps {
                    script {
                        clientImage = docker.build('client:latest', './client')
                        serverImage = docker.build('server:latest', './server')
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
                echo "Login into ECR"
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin \
                $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                '''
            }
        }

        stage('4. Tag and push docker image to ECR') {
            steps {
                script {
                    echo "Tag and push docker image to ECR"
                    def ecrClientImageName = "${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_REGION}.amazonaws.com/client:latest"
                    def ecrServerImageName = "${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_REGION}.amazonaws.com/server:latest"

                    clientImage.tag(ecrClientImageName)
                    serverImage.tag(ecrServerImageName)

                    clientImage.push(ecrClientImageName)
                    serverImage.push(ecrServerImageName)
                }

            }
        }

        // stage('5. Provision the infra for ECS cluster') {
        //     steps {
        //         sh '''
        //         cd ./infra
        //         terraform init
        //         terraform apply --auto-approve
        //         '''
        //     }
        // }
    }

    post {
        always {
            echo 'Pipeline execution complete'
        }
    }

}