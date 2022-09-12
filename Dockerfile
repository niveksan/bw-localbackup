# docker build --no-cache --network=host -t bitwarden_rs-local-backup:arm .
# docker-compose up -d ODER docker run --network=host --rm -it bitwarden_rs-local-backup:arm sh
#FROM alpine:latest
FROM alpine:3.10


# install sqlite, curl, bash (for script)
RUN apk add --no-cache \
  sqlite=3.39 \
  curl \
  bash


# copy backup script to crond daily folder
COPY backup.sh /

# copy entrypoint to usr bin
COPY entrypoint.sh /

# give execution permission to scripts
RUN chmod +x /entrypoint.sh && \
    chmod +x /backup.sh

RUN echo "0 */6 * * * /backup.sh" > /etc/crontabs/root

ENTRYPOINT ["/entrypoint.sh"]
#CMD ["/bin/sh","/entrypoint.sh"]