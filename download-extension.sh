#!/bin/sh

BRANCH=REL1_39
EXTENSION="$1"

git clone -b "$BRANCH" --depth 1 https://gerrit.wikimedia.org/r/mediawiki/extensions/"$EXTENSION" /var/lib/mediawiki/extensions/"$EXTENSION"

if [ -f /var/lib/mediawiki/extensions/"$EXTENSION"/composer.json ]; then
	cd /var/lib/mediawiki/extensions/"$EXTENSION"
	composer install
fi
