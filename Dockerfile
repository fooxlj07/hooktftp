FROM golang

RUN apt-get update \
	&& apt-get install -y bzr-git atftp \
	&& apt-get clean

VOLUME /var/lib/tftpboot

COPY . /app
WORKDIR /app

RUN make build

RUN echo '\
user: nobody\n\
\n\
hooks:\n\
    - type: file\n\
      regexp: ^.*$\n\
      template: /var/lib/tftpboot/$0' > /etc/hooktftp.yml

ENTRYPOINT ["/app/hooktftp"]
