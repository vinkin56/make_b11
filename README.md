# make_b11
Проектная работа 11

Выполнена в jenkins
Jenkinsfile - это pipeline подтягивается из репозитория при запуске
Выполняется запуск docker контейнера, использовал официальный образ

в каталоге www/index.htm страничка она подкладывается в контейнер через volume

md5.sh - скрипт проверяет хэш md5 страниц, если неверно отправляет письмо

serverstatus.sh - проверяет статус сервера, если ответ статуса отличный от 200 отправляет письмо
Скрин настройки автозапуска при новом коммите

Лог:
Checking out git https://github.com/vinkin56/make_b11 into /var/lib/jenkins/workspace/myfirst@script/af09040db76cd75c4d81e26355eb2c4135b8aa19211f2184bd474636229b16d4 to read Jenkinsfile
The recommended git tool is: NONE
using credential e189dfe8-4ec0-4190-b07f-3415a80ca717
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/myfirst@script/af09040db76cd75c4d81e26355eb2c4135b8aa19211f2184bd474636229b16d4/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/vinkin56/make_b11 # timeout=10
Fetching upstream changes from https://github.com/vinkin56/make_b11
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_SSH to set credentials for ssh
Verifying host key using known hosts file
 > git fetch --tags --force --progress -- https://github.com/vinkin56/make_b11 +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
Checking out Revision 2b941b06a814ff144dc18d026079244ccae72c92 (refs/remotes/origin/master)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 2b941b06a814ff144dc18d026079244ccae72c92 # timeout=10
Commit message: "Update index.html"
 > git rev-list --no-walk ea218e71c28d2b7af2b6edc0dd187edce79d9fe8 # timeout=10
[Pipeline] Start of Pipeline
[Pipeline] node
Running on node01 in /home/vinkin/jenkins/workspace/myfirst
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
The recommended git tool is: NONE
using credential e189dfe8-4ec0-4190-b07f-3415a80ca717
Fetching changes from the remote Git repository
 > git rev-parse --resolve-git-dir /home/vinkin/jenkins/workspace/myfirst/.git # timeout=10
 > git config remote.origin.url https://github.com/vinkin56/make_b11 # timeout=10
Fetching upstream changes from https://github.com/vinkin56/make_b11
 > git --version # timeout=10
 > git --version # 'git version 2.34.1'
using GIT_SSH to set credentials for ssh
Verifying host key using known hosts file
 > git fetch --tags --force --progress -- https://github.com/vinkin56/make_b11 +refs/heads/*:refs/remotes/origin/* # timeout=10
Checking out Revision 2b941b06a814ff144dc18d026079244ccae72c92 (refs/remotes/origin/master)
Commit message: "Update index.html"
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Стартуем docker)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 2b941b06a814ff144dc18d026079244ccae72c92 # timeout=10
+ sudo docker run --rm -d -p 9889:80 --name nginx -v /home/vinkin/jenkins/workspace/myfirst/www:/usr/share/nginx/html:ro nginx
9db596b18184acd5a24ac4e7542cfbc708c4b44e904901edaae896678fc826d2
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (проверяем статус сервера)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ bash -vx serverstatus.sh
status="$(curl -o /dev/null -Iksw "%{http_code}" http://158.160.41.146:9889)"
++ curl -o /dev/null -Iksw '%{http_code}' http://158.160.41.146:9889
+ status=000

if [ "$status" = "200" ]
then
  echo -e "Server status OK"
else
  echo 'Status server ERROR' | mail -s 'Warning server not available' -A /var/log/maillog  it.andreys@yandex.ru
fi
+ '[' 000 = 200 ']'
+ echo 'Status server ERROR'
+ mail -s 'Warning server not available' -A /var/log/maillog it.andreys@yandex.ru
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (проверяем md5 index.html)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ bash -vx md5.sh
online_md5="$(curl -sL http://158.160.41.146:9889 | md5sum | cut -d ' ' -f 1)"
++ cut -d ' ' -f 1
++ md5sum
++ curl -sL http://158.160.41.146:9889
+ online_md5=25dc409b440ff4c19f22ad1c53ff643e
local_md5="$(md5sum "${WORKSPACE}/www/index.html" | cut -d ' ' -f 1)"
++ md5sum /home/vinkin/jenkins/workspace/myfirst/www/index.html
++ cut -d ' ' -f 1
+ local_md5=25dc409b440ff4c19f22ad1c53ff643e

if [ "$online_md5" = "$local_md5" ]; then
    echo "Ok!"
 else
 echo 'MD5 Incorrect' | mail -s 'Warning md5 Incorrect' -A /var/log/maillog  it.andreys@yandex.ru
fi
+ '[' 25dc409b440ff4c19f22ad1c53ff643e = 25dc409b440ff4c19f22ad1c53ff643e ']'
+ echo 'Ok!'
Ok!
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Останавливаем docker контейнер)
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ sudo docker stop nginx
nginx
[Pipeline] }
[Pipeline] // script
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
