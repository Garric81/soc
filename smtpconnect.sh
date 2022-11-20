#!/bin/bash -
#
# Bash и кибербезопасность
# smtpconnect.sh
#
# Описание:
# Подключение к SMTP-серверу и печать приветственного баннера
# $ ./smtpconnect.sh 192.168.0.16
# Использование:
# smtpconnect.sh <host>
#   <host> SMTP-сервер для соединения
#
exec 3<>/dev/tcp/"$1"/25
echo -e 'quit\r\n' >&3
cat <&3