#!/bin/bash	
    apt-get update
    apt-get install -y dialog
      apt-get install -y apt-utils
      apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	cat > /root/debconf-slapd.conf << 'EOF'
debconf debconf/frontend select Noninteractive
slapd slapd/password1 password admin
slapd slapd/internal/adminpw password admin
slapd slapd/internal/generated_adminpw password admin
slapd slapd/password2 password admin
#slapd slapd/unsafe_selfwrite_acl note
#slapd slapd/purge_database boolean false
slapd slapd/domain string paneschucos.occ.ues.edu.sv
#slapd slapd/ppolicy_schema_needs_update select abort installation
slapd slapd/invalid_config boolean true
#slapd slapd/move_old_database boolean false
slapd slapd/backend select MDB
slapd shared/organization string paneschucos
#slapd slapd/dump_database_destdir string /var/backups/slapd-VERSION
#slapd slapd/no_configuration boolean false
#slapd slapd/dump_database select when needed
slapd slapd/password_mismatch note
EOF
cat /root/debconf-slapd.conf | debconf-set-selections
apt-get install -y -q slapd
      service slapd start
