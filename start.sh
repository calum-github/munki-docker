#!/bin/bash

# Start up php5-fpm
echo "*** Starting PHP5-FPM ***"
echo ""
service php5-fpm start
echo "*** PHP Started ***"
echo ""

# Start up nginx
echo "*** Starting NGINX ***"
nginx