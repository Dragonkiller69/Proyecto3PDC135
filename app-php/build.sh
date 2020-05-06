#!/bin/bash

docker build -t "apachephpldap" .

docker run --name=server1 -p 80:80 -it -d apachephpldap 
docker run --name=server2 -p 81:80 -it -d apachephpldap 
docker run --name=server3 -p 82:80 -it -d apachephpldap 
