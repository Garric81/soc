#!/bin/bash -
#
# Bash и кибербезопасность
# wintail.sh
#
# Описание:
# Выполнение функции наподобие tail для журнала Windows
#
# Использование: ./wintail.sh
#
WINLOG="Application"
LASTLOG=$(wevtutil qe "$WINLOG" //c:1 //rd:true //f:text)
while true
do
CURRENTLOG=$(wevtutil qe "$WINLOG" //c:1 //rd:true //f:text)
if [[ "$CURRENTLOG" != "$LASTLOG" ]]
then
echo "$CURRENTLOG"
echo "----------------------------------"
LASTLOG="$CURRENTLOG"
fi
done