FROM ubuntu:xenial
MAINTAINER Thomas Steinbach <thomass@aikq.de>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https && \
    echo "deb https://packages.inverse.ca/SOGo/nightly/2/ubuntu xenial xenial" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keys.gnupg.net --recv-key 0x810273C4 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y sogo && \
    apt-get clean

COPY start.sh /usr/local/bin/start.sh
COPY backup /usr/local/bin/backup
COPY restore /usr/local/bin/restore
COPY addsogouser /usr/local/bin/addsogouser
COPY delsogouser /usr/local/bin/delsogouser

RUN mkdir /backups && \
    chown sogo:sogo /backups && \
    chmod 700 /usr/local/bin/addsogouser /usr/local/bin/delsogouser && \
    chsh -s /bin/bash sogo && \
    cp /etc/sogo/sogo.conf /sogo-orig.conf

VOLUME ["/backups"]
VOLUME ["/var/log/sogo"]
VOLUME ["/etc/sogo"]

EXPOSE 20000

CMD ["start.sh"]
