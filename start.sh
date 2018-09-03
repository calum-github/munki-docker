#!/bin/bash

# Start up php5-fpm
echo "- Starting php7.0-fpm..."
echo ""
service php7.0-fpm start
# Start up nginx
echo "- Starting nginx..."
nginx