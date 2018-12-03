# gollum-docker

I don't trust containers build by others, so that's how I build gollum for my personal use.

See also:

* https://github.com/gollum/gollum/wiki
* https://github.com/gollum/gollum/wiki/Gollum-via-Docker

How to run (simple version):

`sudo docker run --rm -p 8080:80 -v $(pwd):/wiki scolytus/gollum`

