#Configuracion de  LDAP-SLAVE
FROM debian:bullseye
RUN apt-get update && echo 'slapd/root_password password password' | debconf-set-selections &&\
    echo 'slapd/root_password_again password password' | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y slapd ldap-utils

## configurar slapd
RUN echo "slapd slapd/no_configuration boolean false" | debconf-set-selections \
&& echo "slapd slapd/domain string paneschucos.occ.ues.edu.sv" | debconf-set-selections \
&& echo "slapd shared/organization string 'paneschucos'" | debconf-set-selections \
&& echo "slapd slapd/password1 password admin" | debconf-set-selections \
&& echo "slapd slapd/password2 password admin" | debconf-set-selections \
&& echo "jslapd slapd/backend select HDB" | debconf-set-selections \
&& echo "slapd slapd/purge_database boolean true" | debconf-set-selections \
&& echo "slapd slapd/allow_ldap_v2 boolean false" | debconf-set-selections \
&& echo "slapd slapd/move_old_database boolean true" | debconf-set-selections 

RUN dpkg-reconfigure -f noninteractive slapd
RUN apt-get install -y wget && wget https://raw.githubusercontent.com/asterisk/asterisk/master/contrib/scripts/asterisk.ldif -P /etc/ldap/schema && \
wget https://raw.githubusercontent.com/asterisk/asterisk/master/contrib/scripts/asterisk.ldap-schema -P /etc/ldap/schema && \
mv /etc/ldap/schema/asterisk.ldap-schema /etc/ldap/schema/asterisk.schema 
#crear archivos de config para replicacion .ldif
WORKDIR /
RUN echo "\
dn: olcDatabase={1}mdb,cn=config\n\
changetype: modify\n\
add: olcSyncRepl\n\
olcSyncRepl: rid=001\n\
  provider=ldap://IPMASTER:389/\n\
  bindmethod=simple\n\
  binddn=\"cn=admin,dc=paneschucos,dc=occ,dc=ues,dc=edu,dc=sv\"\n\
  credentials=admin\n\
  searchbase=\"dc=paneschucos,dc=occ,dc=ues,dc=edu,dc=sv\"\n\
  scope=sub\n\
  schemachecking=on\n\
  type=refreshAndPersist\n\
  retry=\"30 5 300 3\"\n\
  interval=00:00:05:100" > syncrepl.ldif

#exponer puerto de ldap
EXPOSE 389

RUN echo "#\!/bin/bash \n\
echo \$IPMASTER && echo \${IP1MASTER} && \
sed -i -e \"s/IPMASTER/\$IPMASTER/\" syncrepl.ldif && \
service slapd start  && \
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/asterisk.ldif \
&& ldapadd -Y EXTERNAL -H ldapi:/// -f syncrepl.ldif && tail -f /dev/null " > entrypoint.sh && chmod +x entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
