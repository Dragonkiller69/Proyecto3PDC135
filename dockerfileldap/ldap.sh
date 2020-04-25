#!/bin/bash	
    apt-get update
    apt-get install -y dialog
      apt-get install -y apt-utils
      apt-get install -y debconf-utils
	export DEBIAN_FRONTEND=noninteractive
	echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
      echo "slapd slapd/password1 password admin" | debconf-set-selections
      echo "slapd slapd/internal/adminpw password admin" | debconf-set-selections
      echo "slapd slapd/internal/generated_adminpw password admin" | debconf-set-selections
      echo "slapd slapd/password2 password admin" | debconf-set-selections
      echo -e "slapd slapd/domain string paneschucos.occ.ues.edu.sv" |debconf-set-selections
     echo -e "slapd slapd/root_password_again password admin" |debconf-set-selections
     echo -e "slapd slapd/root_password password admin" |debconf-set-selections
     debconf-get-selections | grep slapd
      apt-get install -y -q slapd
      service slapd start

