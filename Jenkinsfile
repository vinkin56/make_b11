pipeline {
    agent any
    
    stages {
        stage('Стартуем docker') {
            steps {
                script {
                          sh "sudo docker run --rm -d -p 9889:80 --name nginx -v ${WORKSPACE}/www:/usr/share/nginx/html:ro nginx"
                        }
                    }
                                    }
        stage('проверяем md5 index.html') {
            steps {
                script {
                    sh '${WORKSPACE}/md5.sh'
                       }
                   }
                                            }
    }
  }
