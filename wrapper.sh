#Часть III • Тестирование на проникновение
#!/bin/bash -
#
# Bash и кибербезопасность
# wrapper.sh
#
# Описание:
# Пример выполнения зашифрованного «обернутого» скрипта
#
# Использование:
# wrapper.sh
#   Ввести пароль при появлении запроса
#
encrypted='U2FsdGVkX18WvDOyPFcvyvAozJHS3tjrZIPlZM9xRhz0tuwzDrKhKBBuugLxzp7T
MoJoqx02tX7KLhATS0Vqgze1C+kzFxtKyDAh9Nm2N0HXfSNuo9YfYD+15DoXEGPd'
read -s word
innerScript=$(echo "$encrypted" | openssl aes-256-cbc -base64 -d -pass
pass:"$word")
eval "$innerScript"