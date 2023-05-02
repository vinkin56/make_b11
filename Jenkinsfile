pipeline {
    agent {
        docker {
                image 'nginx:latest'
                args '-p 9889:80'
                }
           }
    stages {
        stage('Build') {
            steps {
                script {
                          sh "curl -s http://localhost:9889"
                }
            }
        }
    }
          }
