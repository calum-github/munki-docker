# Munki-Docker

Version: 0.4.0
Date: 04/09/2018
Author: Calum Hunter

This is my version of having a Munki repository in a Docker container.

PHP7.0-fpm is also included to allow for php scripts to run inside the munki repo
such as munki-enroll

I am using `Debian:stretch` as a base image.

The `nginx.conf` file has been tweaked to suit a 2 core CPU system ie `worker_processes = 2`

As the data in a Munki repo is served over HTTP using Nginx, other tweaks have been included 
that are designed to increase performance of Nginx when it is serving large static files. 
ie. output buffers increased and sendfile off, keepalive times increased ect


## Usage

Lets assume that you have your munki repository at `/webroot/munki_repo` on your host
inside this `/webroot/munki_repo` directory you have your regular munki directories like
 
    ├── catalogs
    ├── client_resources
    ├── icons
    ├── manifests
    ├── pkgs
    └── pkgsinfo

Now just run the docker container like this:

    docker run -d -p 80:80 -v /webroot:/webroot --name munki_repo hunty1/munki-docker

The `-p 80:80` maps the hosts port 80 to the containers port 80, if you would like to hit your munki server on a different port
for example say 8080 because your host already has a webserver running on 80 you could change this to 
`-p 8080:80` 
Now when the host receives a request on 8080 it forwards that to the docker container on port 80.

The `-v /webroot:/webroot` mounts the folder on the host at `/webroot` into `/webroot` in the container, this is the root
directory that is served via Nginx in the docker container.

The `--name` simply gives the container a name instead of a random one given to it by docker.

The `hunty1/munki-docker` is simply the location of the image on the docker public registry. ie. username/imagename

Lets say you have a `Chrome.dmg` inside your pkgs folder. Once the container is running you should be able to open a web browser
and navigate to `http://ip-or-dns-name-of-your-docker-host/pkgs/Chrome.dmg`
The file should then download. If it works your good to go!


