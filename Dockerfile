# Используем официальный образ Postfix
FROM postfix:latest

# Настройка необходимых переменных окружения
ENV MAIL_NAME=yourdomain.com
ENV SMTP_USER=user:password

# Настройка конфигурации Postfix
RUN postconf -e "myhostname = $MAIL_NAME"
RUN postconf -e "mydomain = $MAIL_NAME"
RUN postconf -e "myorigin = /etc/mailname"
RUN postconf -e "relayhost ="
RUN postconf -e "inet_interfaces = all"
RUN postconf -e "inet_protocols = all"

# Создание пользователя для SMTP
RUN useradd -r -m -d /var/spool/postfix -s /sbin/nologin -g postfix user

# Установка и запуск Postfix
CMD service postfix start && tail -f /var/log/mail.log
