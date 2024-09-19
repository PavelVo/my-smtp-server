# Используем более легковесный образ
FROM alpine:latest

# Устанавливаем необходимые пакеты
RUN apk add --no-cache postfix

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

# Открываем порт 25 для SMTP
EXPOSE 25

# Установка и запуск Postfix
CMD ["postfix", "start-fg"]
