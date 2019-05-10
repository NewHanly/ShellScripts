#!/bin/bash
aria2c --conf-path=/etc/aria2/aria2.conf -D
docker run -d -v nextcloud:/var/www/html -p 8088:80 nextcloud
