FROM 172.30.1.1:5000/sogo/sogo:latest

FROM httpd:2.4
MAINTAINER Thomas Steinbach

COPY --from=0 /usr/lib/GNUstep/SOGo /usr/lib/GNUstep/SOGo

COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY start-docker.sh /usr/local/bin/start-docker.sh

RUN chown -R root:www-data \
      /usr/local/apache2 \
      /usr/lib/GNUstep/SOGo

CMD ["/usr/local/bin/start-docker.sh"]
