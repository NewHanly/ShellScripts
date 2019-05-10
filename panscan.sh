#!/bin/bash
pa=/var/lib/docker/volumes/nextcloud/_data/data/hanly/files/
dockerid=$(docker ps | grep 8088 | awk -F '  +' '{print $7}')
if [ -z $dockerid ]
then
	echo 'docker not found'
	exit
fi
echo $dockerid
chown www-data -R $pa && chgrp www-data -R $pa
docker exec  --user www-data $dockerid php occ files:scan hanly
