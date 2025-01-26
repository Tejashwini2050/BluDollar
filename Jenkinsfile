pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "tejashwini1743/bluedollar" // Replace with your Docker Hub username/repo
    }
    stages {
        stage('Clone Repository') {
            steps {
                // Clone GitHub repository
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                bat 'npm install' // Use 'bat' for Windows commands
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    bat '''
                    docker build -t %DOCKER_IMAGE%:latest .
                    '''
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'f9154827-c7fa-472f-8a30-d2f2a36d113b', url: '']) {
                        bat 'docker push %DOCKER_IMAGE%:latest'
                    }
                }
            }
        }
        stage('Run Container') {
            steps {
                script {
                    bat '''
                    docker run -d -p 3000:3000 --name bluedollar %DOCKER_IMAGE%:latest
                    '''
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed.'
        }
        cleanup {
            echo 'Cleaning up...'
            bat 'docker container prune -f || exit 0'
            bat 'docker image prune -f || exit 0'
        }
    }
}
