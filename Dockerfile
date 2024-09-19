# Используем базовый образ Ubuntu
FROM ubuntu:latest

# Проверка версии операционной системы
RUN cat /etc/os-release

# Устанавливаем необходимые пакеты
RUN apt-get update && apt-get install -y postfix mailutils

# Настройка необходимых переменных окружения
ENV MAIL_NAME=yourdomain.com
ENV SMTP_USER=user:password

# Настройка конфигурации Postfix
RUN postconf -e "myhostname = $MAIL_NAME" \
    && postconf -e "mydomain = $MAIL_NAME" \
    && postconf -e "myorigin = /etc/mailname" \
    && postconf -e "relayhost =" \
    && postconf -e "inet_interfaces = all" \
    && postconf -e "inet_protocols = all"

# Создание пользователя для SMTP
RUN useradd -r -m -d /var/spool/postfix -s /sbin/nologin -g postfix user

# Открываем порт 25 для SMTP
EXPOSE 25

# Установка и запуск Postfix
CMD service postfix start && tail -f /var/log/mail.log
