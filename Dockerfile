FROM mediawiki:1.35.1 as builder

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/OAuth-REL1_35-c66d882.tar.gz -o /tmp/oauth.tar.gz
RUN tar -xzf /tmp/oauth.tar.gz -C /tmp

FROM mediawiki:1.35.1

COPY --from=builder /tmp/OAuth /var/www/html/extensions/OAuth
