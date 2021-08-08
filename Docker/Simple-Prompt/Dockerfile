FROM busybox

ADD run.sh /run.sh
RUN chmod 777 /run.sh
ENV LISTEN_PORT=80

EXPOSE 80
CMD /run.sh