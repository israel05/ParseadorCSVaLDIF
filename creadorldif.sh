#!/bin/bash
# creo una variable de cadena donde concatenar la linea
let frasecompuesta
dominio="Korriban"
#leo un archivo CSV
cat muestra100curada.csv  |
#inicio un bucle para leer los diferentes campos
# para passd while IFS=: read user pass uid gid fullname homedir shell
while IFS=, read  c1 c2 c3 c4 
do
	frasecompuesta="dn: uid=$c2,ou=pilotos,dc=korriban,dc=sith"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="objectClass: inetOrgPerson"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="objectClass: posixAccount"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="objectClass: shadowAccount"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="cn: $c2"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="sn: $c2"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="uid: $c2"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="uidNumber: $c1"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="gidNumber: $c3"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="userPassword: $c2"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="homeDirectory: /home/$c2"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="loginShell: /bin/bash"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="gecos: $c2"
	echo $frasecompuesta >>salida.txt
	frasecompuesta="description: User account"
	echo $frasecompuesta >>salida.txt
	





#linea en blanco para finalizar el registro que entra en el OPENLDAP
	printf "\n" >>salida.txt	
done
exit 0 
