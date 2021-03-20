FROM mediawiki:1.35.1 as builder

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/OAuth-REL1_35-35d6745.tar.gz -o /tmp/oauth.tar.gz
RUN tar -xzf /tmp/oauth.tar.gz -C /tmp

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/PluggableAuth-master-2a465ae.tar.gz -o /tmp/pluggableauth.tar.gz
RUN tar -xzf /tmp/pluggableauth.tar.gz -C /tmp

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/OpenIDConnect-master-05d76c0.tar.gz -o /tmp/openidconnect.tar.gz
RUN tar -xzf /tmp/openidconnect.tar.gz -C /tmp

RUN curl -sL https://extdist.wmflabs.org/dist/skins/Cosmos-REL1_35-0418032.tar.gz -o /tmp/cosmos.tar.gz
RUN tar -xzf /tmp/cosmos.tar.gz -C /tmp

FROM mediawiki:1.35.1

COPY --from=builder /tmp/OAuth /var/www/html/extensions/OAuth
COPY --from=builder /tmp/PluggableAuth /var/www/html/extensions/PluggableAuth
COPY --from=builder /tmp/OpenIDConnect /var/www/html/extensions/OpenIDConnect
COPY --from=builder /tmp/Cosmos /var/www/html/skins/Cosmos
