FROM debian:bullseye as builder

RUN apt-get clean && apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --yes git composer php-curl unzip mediawiki

RUN mkdir -pv /var/lib/mediawiki/extensions
COPY download-extension.sh /usr/local/bin/download-extension

RUN download-extension OAuth
RUN download-extension TemplateStyles
RUN download-extension PluggableAuth
RUN download-extension OpenIDConnect

FROM debian:bullseye

RUN apt-get clean && apt-get update
RUN apt-get install --no-install-recommends --yes ca-certificates

COPY apt/taavi.asc /etc/apt/trusted.gpg.d/taavi.asc
COPY apt/sources.list /etc/apt/sources.list.d/taavi.list

RUN apt-get clean && apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --yes apache2 mediawiki mediawiki-extension-codemirror php-mysql php-redis php-apcu php-curl php-gmp imagemagick php-yaml php-wikidiff2 python3-pygments php-luasandbox

RUN a2enmod rewrite
RUN rm /etc/apache2/conf-enabled/mediawiki.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf
COPY site.conf /etc/apache2/sites-enabled/mediawiki.conf

COPY --from=builder /var/lib/mediawiki/extensions/OAuth /var/lib/mediawiki/extensions/OAuth
COPY --from=builder /var/lib/mediawiki/extensions/TemplateStyles /var/lib/mediawiki/extensions/TemplateStyles
COPY --from=builder /var/lib/mediawiki/extensions/PluggableAuth /var/lib/mediawiki/extensions/PluggableAuth
COPY --from=builder /var/lib/mediawiki/extensions/OpenIDConnect /var/lib/mediawiki/extensions/OpenIDConnect

EXPOSE 80
CMD [ "apache2ctl", "-DFOREGROUND" ]
