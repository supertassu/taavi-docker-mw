FROM mediawiki:1.35.1 as builder

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/OAuth-REL1_35-70588c6.tar.gz -o /tmp/oauth.tar.gz
RUN tar -xzf /tmp/oauth.tar.gz -C /tmp

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/TemplateStyles-REL1_35-7a40a6a.tar.gz -o /tmp/templatestyles.tar.gz
RUN tar -xzf /tmp/templatestyles.tar.gz -C /tmp

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/CodeMirror-REL1_35-b5c9a1b.tar.gz -o /tmp/codemirror.tar.gz
RUN tar -xzf /tmp/codemirror.tar.gz -C /tmp

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/PluggableAuth-REL1_35-2a465ae.tar.gz -o /tmp/pluggableauth.tar.gz
RUN tar -xzf /tmp/pluggableauth.tar.gz -C /tmp

RUN curl -sL https://extdist.wmflabs.org/dist/extensions/OpenIDConnect-REL1_35-05d76c0.tar.gz -o /tmp/openidconnect.tar.gz
RUN tar -xzf /tmp/openidconnect.tar.gz -C /tmp

RUN curl -sL https://extdist.wmflabs.org/dist/skins/Cosmos-master-55fd166.tar.gz -o /tmp/cosmos.tar.gz
RUN tar -xzf /tmp/cosmos.tar.gz -C /tmp

FROM mediawiki:1.35.1

COPY --from=builder /tmp/OAuth /var/www/html/extensions/OAuth
COPY --from=builder /tmp/PluggableAuth /var/www/html/extensions/PluggableAuth
COPY --from=builder /tmp/OpenIDConnect /var/www/html/extensions/OpenIDConnect
COPY --from=builder /tmp/TemplateStyles /var/www/html/extensions/TemplateStyles
COPY --from=builder /tmp/CodeMirror /var/www/html/extensions/CodeMirror
COPY --from=builder /tmp/Cosmos /var/www/html/skins/Cosmos
