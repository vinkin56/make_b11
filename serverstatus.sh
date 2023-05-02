status="$(curl -o /dev/null -Iksw "%{http_code}" http://158.160.41.146:9889)"

if [ "$status" = "200" ]
then
  echo -e "Server status OK"
else
  echo 'Status server ERROR' | mail -s 'Warning server not available' -A /var/log/maillog  it.andreys@yandex.ru
fi
