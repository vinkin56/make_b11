pipeline {
    agent any
    
    stages {
        stage('start docker') {
            steps {
                script {
                          sh "sudo docker run --rm -d -p 9889:80 --name nginx -v ${WORKSPACE}/www:/usr/share/nginx/html:ro nginx"
                        }
                    }
                                    }
        stage('проверяем статус сервера') {
        if (theStage in ["start docker","all"]) {
    sleep 2
            steps {
                script {
                    sh 'bash -vx serverstatus.sh'
                       }
                   }
                                            }
        stage('проверяем md5 index.html') {
            steps {
                script {
                    sh 'bash -vx md5.sh'
                       }
                   }
                                            }
         stage('Останавливаем docker контейнер') {
            steps {
                script {
                    sh 'sudo docker stop nginx'
                       }
                   }
                                            }
    }
  }
