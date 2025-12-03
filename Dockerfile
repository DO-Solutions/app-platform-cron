FROM alpine:3.23

RUN apk add --no-cache ca-certificates curl \
    && update-ca-certificates

COPY crontab /etc/cron.d/hello-cron
COPY entrypoint.sh /entrypoint.sh

RUN chmod 0644 /etc/cron.d/hello-cron \
    && chmod +x /entrypoint.sh \
    && crontab /etc/cron.d/hello-cron

ENTRYPOINT ["/entrypoint.sh"]

CMD ["crond", "-f", "-l", "2"]