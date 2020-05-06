# Install 
    $sh build.sh
# Clear
    $sh clear.sh

# Test
    http://localhost:80/phpl-dap-asterisk
    http://localhost:81/phpl-dap-asterisk
    http://localhost:82/phpl-dap-asterisk

# Configurar ldap server en la app
    1. Editar el archivo phpl-dap.-asterisk/auth/auth.php  la propiedad $config['urlLdap']='ldap://172.17.0.5:389', cambiar la ip segun su servidor ldap.
    
    2. Tambien puede configurar el dominio de directorio en la variable $config de ese mismo archivo segun
    corresponda.

# Custom
    0. Para configurar el nombre del servidor actual en la barra de navegacion editar el archivo header.php
    y reemplazar en la etiqueta nav server1 segun corresponda.

    1. Si solo se desea crear los contenedores comentar la linea 3 con el caracter # del archivo build.sh

    2. Si solo se desea parar los contenedores sin borrarlos, comentar la linea 3 con el caracter # del archivo clear.sh

    3. Si se desea hacer lo inverso proceder a comentar las lineas que interese.