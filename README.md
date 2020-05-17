# gollum-docker

I don't trust containers build by others, so that's how I build gollum for my personal use.

See also:

* https://github.com/gollum/gollum/wiki
* https://github.com/gollum/gollum/wiki/Gollum-via-Docker

How to run (simple version):

`sudo docker run --rm -p 127.0.0.1:3080:8080 -v $(pwd):/wiki scolytus/gollum:latest --port 8080 --emoji`

* the current working directory will be used as the wiki to serve
* make sure the current working directory contains an **already initialized** git repository
* you can access your wiki under http://localhost:3080/
