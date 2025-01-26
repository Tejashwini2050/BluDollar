pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "your-dockerhub-username/bluedollar" // Replace with your Docker Hub repo
    }
    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                bat 'npm install' // Installs Node.js dependencies
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE%:latest .'
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'docker-cred', url: '']) {
                        bat 'docker push %DOCKER_IMAGE%:latest'
                    }
                }
            }
        }
        stage('Deploy Docker Container') {
            steps {
                bat """
                docker stop bluedollar || true
                docker rm bluedollar || true
                docker run -d -p 3000:3000 --name bluedollar %DOCKER_IMAGE%:latest
                """
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed successfully.'
        }
    }
}
