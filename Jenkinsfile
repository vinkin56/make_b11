pipeline {
    agent {
        docker {
                image 'nginx'
                args '-d -p 9889:80 --name nginx -v ${WORKSPACE}/www:/usr/share/nginx/html:ro nginx'
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
