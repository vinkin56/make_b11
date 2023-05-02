pipeline {
    agent {
        docker {
                image 'nginx'
                args '-it --rm -p 9889:80 --name nginx -v ${WORKSPACE}/www:/usr/share/nginx/html -d nginx'
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
