# Definir o usuário não-root (por exemplo, UID 1001)
USER 1001

#Based Image
FROM debian:11.6

#Don't ask confirmation
ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
&& apt install --yes --no-install-recommends \
wget \
ca-certificates \
cron \
apache2 \
perl \
curl \
jq \
php \
&& apt install --yes --no-install-recommends \
php-ldap \
php-imap \
php-apcu \
php-xmlrpc \
php-cas \
php-mysqli \
php-mbstring \
php-curl \
php-gd \
php-simplexml \
php-xml \
php-intl \
php-zip \
php-bz2 \
&& rm -rf /var/lib/apt/lists/*

VOLUME /app

# Copy entrypoint make it as executable and run it
COPY entrypoint.sh /opt/
RUN chmod +x /opt/entrypoint.sh
RUN chmod -R 777 /app
RUN chmod 777 /etc/cron.d/glpi
RUN chmod 777 /etc/apache2/apache2.conf \
    && chmod 777 /etc/apache2/sites-available/000-default.conf

ENTRYPOINT ["/opt/entrypoint.sh"]
#ENTRYPOINT [ "/bin/bash", "-c", "source ~/.bashrc && /opt/entrypoint.sh ${@}", "--" ]

#Expose ports
#EXPOSE 80 443
