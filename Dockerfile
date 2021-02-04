FROM mediawiki:1.35.1 as builder

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/OAuth-REL1_35-c66d882.tar.gz -o /tmp/oauth.tar.gz
RUN tar -xzf /tmp/oauth.tar.gz -C /tmp

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/PluggableAuth-master-203b5ad.tar.gz -o /tmp/pluggableauth.tar.gz
RUN tar -xzf /tmp/pluggableauth.tar.gz -C /tmp

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/OpenIDConnect-master-f4dd84d.tar.gz -o /tmp/openidconnect.tar.gz
RUN tar -xzf /tmp/openidconnect.tar.gz -C /tmp

FROM mediawiki:1.35.1

COPY --from=builder /tmp/OAuth /var/www/html/extensions/OAuth
COPY --from=builder /tmp/PluggableAuth /var/www/html/extensions/PluggableAuth
COPY --from=builder /tmp/OpenIDConnect /var/www/html/extensions/OpenIDConnect
