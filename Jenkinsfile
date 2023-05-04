pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-web-app .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                }
                sh "docker tag my-web-app:latest <docker-hub-username>/my-web-app:latest"
                sh "docker push <docker-hub-username>/my-web-app:latest"
            }
        }

        stage('Deploy Docker Compose') {
            steps {
                sshagent(['my-ec2-instance']) {
                    sh 'scp -i /path/to/ssh-key docker-compose.yml ec2-user@<ec2-instance-public-ip>:~/docker-compose.yml'
                    sh 'ssh -i /path/to/ssh-key ec2-user@<ec2-instance-public-ip> "docker-compose up -d"'
                }
            }
        }
    }
}
