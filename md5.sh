online_md5="$(curl -sL http://158.160.41.146:9889 | md5sum | cut -d ' ' -f 1)"
local_md5="$(md5sum "${WORKSPACE}/www/index.html" | cut -d ' ' -f 1)"

if [ "$online_md5" = "$local_md5" ]; then
    echo "Ok!"
 else
 echo 'MD5 Incorrect' | mail -s 'Warning md5 Incorrect' -a /var/log/maillog master@dmosk.ru
fi
