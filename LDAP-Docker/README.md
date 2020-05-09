# LDAP-Docker
Dockerfiles para configuración provider-consumer replication ldap

### Pre-requisitos 📋

Tener [docker](https://docs.docker.com/) instalado,consultar https://docs.docker.com/get-docker/ para mayor información deacuerdo a su distribución

### Instalación 🔧

Primero debe construir las imagenes.

_Cada una en su directorio correspondiente_

```
docker build -t ldap:master .
docker build -t ldap:slave .
```

_**crear el contenedor para el master**_

```
docker run -d --name master-ldap -p 389:389 -i ldap:master 
```
_Donde:_


**_-d:_** para liberar la consola

**_--name:_** asignar un nombre al contenedor

**_-p:_** le asignamos el puerto de ldap

**_-i:_** el nombre de la imagen



_**crear el contenedor slave**_

```
docker run -d --name slave-ldap -p 4002:389  -e IPMASTER=x.x.x,x -i ldap:slave
```
_Donde:_


**_-d:_** para liberar la consola

**_--name:_** asignar un nombre al contenedor

**_-p:_** le asignamos el puerto de ldap

**_-i:_** el nombre de la imagen

**_-e_** agregar una variablede entorno, entoces en IPMASTER=x.x.x.x sustituir las x.x.x.x por la dirección ip de su contenedor master.

### y ya tendriamos una configuración ldap con replicación
