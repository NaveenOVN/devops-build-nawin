pipeline {
    agent any
    environment {
        DOCKERHUB = credentials('dockerhub-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/NaveenOVN/devops-build-nawin.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t nawin28/devops-build:latest .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    sh 'echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin'
                    if (env.BRANCH_NAME == 'dev') {
                        sh 'docker tag nawin28/devops-build:latest nawin28/dev:latest'
                        sh 'docker push nawin28/dev:latest'
                    } else if (env.BRANCH_NAME == "master") {
                        sh 'docker tag nawin28/devops-build:latest nawin28/prod:latest'
                        sh 'docker push nawin28/prod:latest'
                    }
                }
            }
        }
    }
}
