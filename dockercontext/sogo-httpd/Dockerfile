# Typically we use Docker Multi Stage Build to retrieve data from:
FROM 172.30.1.1:5000/sogo/sogo:latest
# But in OpenShift we need to use Build Image Input instead.
# Mention the 'COPY --from=0' statement below...

FROM httpd:2.4
MAINTAINER Thomas Steinbach

# This statement we would use in a docker multi stage build:
COPY --from=0 /usr/lib/GNUstep/SOGo /usr/lib/GNUstep/SOGo
# Instead we need to mount the files in the BuildConfig source of openshift:
#COPY sogofiles /usr/lib/GNUstep/SOGo

COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY start-docker.sh /usr/local/bin/start-docker.sh

RUN whoami
RUN chown -R root:www-data /usr/local/apache2
RUN ls -l /usr/lib/GNUstep
RUN chown -R root:www-data /usr/lib/GNUstep/SOGo

CMD ["/usr/local/bin/start-docker.sh"]
