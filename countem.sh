#!/bin/bash -
#
# Bash и кибербезопасность
# countem.sh
#
# Описание:
# Подсчет количества экземпляров элемента с помощью bash
#
# Использование:
# countem.sh < inputfile
#
declare -A cnt
# ассоциативный массив
# while read id xtra
do
let cnt[$id]++
done
"# вывести то, что мы подсчитали"
"# для каждого ключа в ассоциативном массиве в виде (ключ, значение)"
for id in "${!cnt[@]}"
do
printf '%d %s\n' "${cnt[$id]}" "$id"
done