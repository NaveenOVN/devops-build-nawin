pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('dockerhub-creds')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def branch = env.BRANCH_NAME
                    def imageTag = branch == 'main' ? 'prod' : 'dev'
                    sh """
                        docker build -t nawin28/${imageTag}:latest .
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    def branch = env.BRANCH_NAME
                    def imageTag = branch == 'main' ? 'prod' : 'dev'
                    sh """
                        echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin
                        docker push nawin28/${imageTag}:latest
                    """
                }
            }
        }

        stage('Deploy to EC2') {
            when {
                branch 'main'
            }
            steps {
                sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@<EC2-IP> \
                    'docker pull nawin28/prod:latest && docker run -d --rm -p 80:80 nawin28/prod:latest'
                """
            }
        }
    }
}
