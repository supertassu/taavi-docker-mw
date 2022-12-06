#!/bin/bash

while true; do
	php /var/lib/mediawiki/maintenance/runJobs.php --wait --maxjobs=20

	echo Waiting for 10 seconds...
	sleep 10
done

