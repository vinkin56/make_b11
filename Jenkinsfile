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
                    sh 'online_md5="$(curl -sL http://158.160.41.146:9889 | md5sum | cut -d ' ' -f 1)" /
                        local_md5="$(md5sum "/home/vinkin/jenkins/workspace/myfirst/www/index.html" | cut -d ' ' -f 1)" /
                        if [ "$online_md5" = "$local_md5" ]; then /
                        echo "Ok!" /
                        else /
                        echo 'MD5 Incorrect' | mail -s 'Warning md5 Incorrect' -A /var/log/maillog  it.andreys@yandex.ru /
                        fi'
                       }
                   }
                                            }
    }
  }
