pipeline {
    agent {
        docker {
                image 'nginx:latest'
                args '-it --name nginx -p 9889:80 -v ${WORKSPACE}/www:/usr/share/nginx/html -d nginx'
                }
           }
          }
