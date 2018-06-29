#!/bin/bash

# Start up php5-fpm
echo "*** Starting PHP7.0-FPM ***"
echo ""
service php7.0-fpm start
echo "*** PHP Started ***"
echo ""

# Start up nginx
echo "*** Starting NGINX ***"
nginx