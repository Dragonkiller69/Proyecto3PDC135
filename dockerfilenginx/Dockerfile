FROM debian:buster

WORKDIR /etc/nginx/
RUN apt-get update && apt-get install -y nginx && \
    echo ' \
    upstream backend { \n\
        server $IPSERVER1;\n\
	    server $IPSERVER2;\n\
	    server $IPSERVER3;\n\
    }\n\
    server {\n\
	    listen 80 default_server;\n\
	    server_name www.chilate.occ.ues.edu.sv;\n\
	    return 301 https://$host$request_uri;\n\
    }\n\
    server {\n\
	    listen 443 ssl default_server;\n\
	    server_name www.chilate.occ.ues.edu.sv;\n\
	    ssl on;\n\
	    ssl_certificate /etc/nginx/newcert.pem;\n\
	    ssl_certificate_key /etc/nginx/newkey.pem;\n\
	    ssl_trusted_certificate /etc/nginx/cacert.pem;\n\
        location / {\n\
            proxy_pass http://backend/;\n\
        }	\n\
}' > conf.d/load-balancer.conf