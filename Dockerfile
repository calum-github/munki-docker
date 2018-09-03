# Dockerfile for Munki-Docker
# Hopefully a much smaller image than others out there
# This branch includes PHP7 fpm - in case you have some PHP scripts
# you need to run, such as Munki Enroll

# Date:     28-06-2018
# Notes:    Update to latest patches

# Start from Debian because its smaller than Ubuntu but gets the job done.
FROM debian:stretch

MAINTAINER Calum Hunter (calum.h@gmail.com)


# Add the packages we need from apt then remove the cached list saving some disk space
RUN apt-get update && \
	apt-get upgrade && \
	apt-get install -y \
	nginx \
	vim \
	php7.0-xml \
	php7.0-fpm && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Create dirs for Munki
RUN mkdir -p /webroot && \
	mkdir -p /etc/nginx/sites-enabled/ && \
	rm /etc/nginx/sites-enabled/default

# Add Munki config files
ADD nginx.conf /etc/nginx/nginx.conf
ADD munki-repo.conf /etc/nginx/sites-enabled/

# Add start up script
ADD start.sh /start.sh
RUN chmod +x /start.sh

# Set up logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Expose volumes
VOLUME ["/webroot"]

# Expose ports
EXPOSE 80 443

# Lets go!
CMD ["/start.sh"]
