#!/bin/bash

docker rmi apachephpldap
docker stop server1 server2 server3
docker rm server1 server2 server3