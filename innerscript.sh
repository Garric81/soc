# Шифрование сценария
echo "This is an encrypted script"
echo "running uname -a"
uname -a
# "для.шифрования,.так.и.для.дешифрования..Чтобы.зашифровать.файл,.напишите."
#следующее:
openssl aes-256-cbc -base64 -in innerscript.sh -out innerscript.enc -pass pass:mysecret