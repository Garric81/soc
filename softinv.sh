#!/bin/bash -
#
# Bash и кибербезопасность
# softinv.sh
#
# Описание:
# Перечисление установленного в системе программного обеспечения
# для последующего агрегирования и анализа
#
# Использование: ./softinv.sh [filename]
# вывод записывается в $1 или <hostname>_softinv.txt
#
# задаем имя файла вывода
OUTFN="${1:-${HOSTNAME}_softinv.txt}"
"# какая команда будет запущена, зависит от типа и дистрибутива ОС"
OSbase=win
type -t rpm &> /dev/null
(( $? == 0 )) && OSbase=rpm
type -t dpkg &> /dev/null
(( $? == 0 )) && OSbase=deb
type -t apt &> /dev/null
(( $? == 0 )) && OSbase=apt
case ${OSbase} in
win)
INVCMD=""wmic product get name,version //format:csv"
;;
rpm)
INVCMD="rpm -qa"
;;
deb)
INVCMD="dpkg -l"
;;
apt)
  INVCMD="apt list --installed"
;;
*)
echo "error: OSbase=${OSbase}"
exit -1
;;
esac
#
# запустить проверку
#
$INVCMD 2>/dev/null > $OUTFN