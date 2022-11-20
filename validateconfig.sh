# конфигурации
#Инструмент: проверки
#Реализация
#Сценарий.validateconfig.sh.проверяет.следующее:
#наличие.или.отсутствие.файла;
#
#хеш.SHA-1.файла;
#значение.раздела.реестра.Windows;
# наличие.или.отсутствие.пользователя.или.группы.
#!/bin/bash -
#
# Bash и кибербезопасность
# validateconfig.sh
#
# Описание:
# Проверка наличия указанной конфигурации
#
# Использование:
# validateconfig.sh < configfile
#
# спецификация конфигурации выглядит так:
# [[!]file|hash|reg|[!]user|[!]group] [args]
# примеры:
# file /usr/local/bin/sfx             - файл существует
# hash 12384970347 /usr/local/bin/sfx - это хеш файла
# !user bono                          - нет разрешенного пользователя "bono"
# group students                      - должна быть группа students
#
# errexit - показать правильное использование и выйти
function errexit ()
{
echo "invalid syntax at line $ln"
echo "usage: [!]file|hash|reg|[!]user|[!]group [args]"
exit 2
} # errexit
# vfile - проверка наличия имени файла
# аргументы: 1: флаг "нет" - значение:1/0
#       2: имя файла
#
function vfile ()
{
local isThere=0
[[ -e $2 ]] && isThere=1
(( $1 )) && let isThere=1-$isThere
return $isThere
} # vfile
# проверить идентификатор пользователя
function vuser ()
{
local isUser
$UCMD $2 &>/dev/null
isUser=$?
if (( $1 ))
then
let isUser=1-$isUser
fi
return $isUser
} # vuser
# проверить идентификатор группы
function vgroup ()
{
local isGroup
id $2 &>/dev/null
isGroup=$?
if (( $1 ))
then
let isGroup=1-$isGroup
fi
return $isGroup
} # vgroup
# проверить хеш файла
function vhash ()
{
local res=0
local X=$(sha1sum $2)
if [[ ${X%% *} == $1 ]]
then
res=1
fi
return $res
} # vhash
# проверить системный реестр windows
function vreg ()
{
local res=0
local keypath=$1
local value=$2
local expected=$3
local REGVAL=$(query $keypath //v $value)
if [[ $REGVAL == $expected ]]
then
res=1
fi
return $res
} # vreg
#
# main
#
# выполнить один раз, чтобы использовать в проверке идентификаторов пользователей
UCMD="net user"
type -t net &>/dev/null || UCMD="id"
ln=0
while read cmd args
do
let ln++
donot=0
if [[ ${cmd:0:1} == '!' ]]
then
donot=1
basecmd=${cmd#\!}
fi
case "$basecmd" in
file)
OK=1
vfile $donot "$args"
res=$?
;;
hash)
OK=1
# разделить аргументы на первое слово и остаток
vhash "${args%% *}" "${args#* }"
res=$?
;;
reg)
# Только для Windows!
OK=1
vreg $args
res=$?
;;
user)
OK=0
vuser $args
res=$?
;;
group)
OK=0
vgroup $args
res=$?
;;
*)  errexit
;;
esac
if (( res != OK ))
then
echo "FAIL: [$ln] $cmd $args"
fi
done

