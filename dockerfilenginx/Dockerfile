FROM debian:buster

RUN apt-get update && apt-get install -y nginx 
WORKDIR /etc/nginx/
RUN mkdir certificados
ADD certificado/ certificados/
RUN echo ' \
    upstream backend { \n\
		least_conn;\n\ 
        server IPSERVER1;\n\
	    server IPSERVER2;\n\
	    server IPSERVER3;\n\
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
	    ssl_certificate /etc/nginx/certificados/newcert.pem;\n\
	    ssl_certificate_key /etc/nginx/certificados/chilate.key;\n\
	    ssl_trusted_certificate /etc/nginx/certificados/cacert.pem;\n\
        location / {\n\
            proxy_pass http://backend/phpl-dap-asterisk/;\n\
        }	\n\
	}' > conf.d/load-balancer.conf && \
	echo "#\!/bin/bash \n\
		sed -i -e \"s/IPSERVER1/\$IPSERVER1/; s/IPSERVER2/\$IPSERVER2/ ; s/IPSERVER3/\$IPSERVER3/\" /etc/nginx/conf.d/load-balancer.conf && \
		service nginx start && \
		tail -f /dev/null " > entrypoint.sh && chmod +x entrypoint.sh && \
	rm sites-enabled/default
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["/bin/bash", "/etc/nginx/entrypoint.sh"]   