#!/bin/bash
# crea un dialogo con titulo, tipo mensajito, de 20 de ancho por 40 de largo
# dialog --title "Inicio" --msgbox 'Script parseador de CSV a LDIF simplre' 6 30


# un menu con cabeza de página
# dialog --begin 10 30 --backtitle "Programa parseador" \
# --title "Información" \
# --msgbox 'El parseador es un programe en pruebas, no lo use en explotacion.' 10 30

# creo una variable para pasar entre las diferentes funciones los datos de vuelta
let retornoLlamadaAdialogo
#creo un grupo de variables que alamacenan toda la información de la conexión
let nombreArchivoCSV
let usuarioAdministradorLDAP
let primerparteDominio
let segundaparteDominio

salirDelScript=10






# funcion llamadaAdialogoOrigencsv, pide el nombre del archivo csv que se va a leer,
# previamente saneado y en la misma carpeta dónde está este script
# recibe: ningun parámetro
# devuelve: ningún parámetro, pero escribe en una variable global
function llamadaAdialogoOrigencsv(){
    OUTPUT="/tmp/input.txt"
    # Dibuja el InpuntBox
    dialog --title "El nombre del archivo CSV a parsear" \
    --backtitle "Parseador de CSV a LDIP" \
    --inputbox "Indica el nombre del archivo CSV que está en esta carpeta para parsear (ejemplo.csv)" 8 60 2>$OUTPUT
    # lee lo que está escribiendo el usuario
    respose=$?
    # lee lo que hay en OUTPUT usando la redireccion $OUPUT
    name=$(<$OUTPUT)
    # Entra en el case
    case $respose in
      0) echo "hola $name" ;;
      1) echo "Cancel pressed." ;;
      255) echo "[ESC] key pressed."
    esac
    #borrar ese archivo temporal que solo guarda mierda
    rm /tmp/input.txt
    #hace un retorno de la variable
    nombreArchivoCSV=$name
}





# funcion llamadaAdialogoServidor, pide el nombre del archivo csv que se va a leer,
# previamente saneado y en la misma carpeta dónde está este script
# recibe: ningun parámetro
# devuelve: ningún parámetro, pero escribe en una variable global
function llamadaAdialogoServidor(){
    OUTPUT="/tmp/input.txt"
    # Dibuja el InpuntBox
    dialog --title "La primera parte del nombre del dominio" \
    --backtitle "Parseador de CSV a LDIP" \
    --inputbox "Indica la primera parte del nombre de tu dominio (Endor, Yavin)" 8 60 2>$OUTPUT
    # lee lo que está escribiendo el usuario
    respose=$?
    # lee lo que hay en OUTPUT usando la redireccion $OUPUT
    name=$(<$OUTPUT)
    # Entra en el case
    case $respose in
      0) echo "hola $name" ;;
      1) echo "Cancel pressed." ;;
      255) echo "[ESC] key pressed."
    esac
    #borrar ese archivo temporal que solo guarda mierda
    rm /tmp/input.txt
    #hace un retorno de la variable
    primerparteDominio=$name
}



#funcion parsearElCSV, con todos los datos de las variables podemos realizar el parseador
#input nada
#output debe crear un archivo .ldif, más tarde miraremos si existe o si lo que tiene nos gusta

function parsearElCSV(){
  # creo una variable de cadena donde concatenar la linea
  let frasecompuesta
  #dominio="Korriban"
  #leo un archivo CSV
  cat $nombreArchivoCSV  |
  #inicio un bucle para leer los diferentes campos
  # para passd while IFS=: read user pass uid gid fullname homedir shell
  while IFS=, read  c1 c2 c3 c4
  do
  	frasecompuesta="dn: uid=$c2,ou=personas,dc=$primerparteDominio,dc=$segundaparteDominio"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="objectClass: inetOrgPerson"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="objectClass: posixAccount"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="objectClass: shadowAccount"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="cn: $c2"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="sn: $c2"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="uid: $c2"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="uidNumber: $c1"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="gidNumber: $c3"
  	echo $frasecompuesta >>salida.txt
  	frasecompuesta="userPassword: $c2"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="homeDirectory: /home/$c2"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="loginShell: /bin/bash"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="gecos: $c2"
  	echo $frasecompuesta >>salida.ldif
  	frasecompuesta="description: User account"
  	echo $frasecompuesta >>salida.ldif

  #linea en blanco para finalizar el registro que entra en el OPENLDAP
  	printf "\n" >>salida.ldif
  done
}




# funcion llamadaAdialogoExtension, pide el nombre del archivo csv que se va a leer,
# previamente saneado y en la misma carpeta dónde está este script
# recibe: ningun parámetro
# devuelve: ningún parámetro, pero escribe en una variable global
function llamadaAdialogoExtension(){
    OUTPUT="/tmp/input.txt"
    # Dibuja el InpuntBox
    dialog --title "La segunda parte del nombre del dominio" \
    --backtitle "Parseador de CSV a LDIP" \
    --inputbox "Indica la segunda parte del nombre de tu dominio (ally, local)" 8 60 2>$OUTPUT
    # lee lo que está escribiendo el usuario
    respose=$?
    # lee lo que hay en OUTPUT usando la redireccion $OUPUT
    name=$(<$OUTPUT)
    # Entra en el case
    case $respose in
      0) echo "hola $name" ;;
      1) echo "Cancel pressed." ;;
      255) echo "[ESC] key pressed."
    esac
    #borrar ese archivo temporal que solo guarda mierda
    rm /tmp/input.txt
    #hace un retorno de la variable
    segundaparteDominio=$name
}




# funcion llamadaAdialogoNombreAdmin, pide el del admin de OPENLDAP
# recibe: ningun parámetro
# devuelve: ningún parámetro, pero escribe en una variable global
function llamadaAdialogoNombreAdmin(){
    OUTPUT="/tmp/input.txt"
    # Dibuja el InpuntBox
    dialog --title "El nombre del administrador OpenLDAP" \
    --backtitle "Parseador de CSV a LDIP" \
    --inputbox "Indica el nombrel del usuario administrador OpenLDAP (admin por ejemplo)" 8 60 2>$OUTPUT
    # lee lo que está escribiendo el usuario
    respose=$?
    # lee lo que hay en OUTPUT usando la redireccion $OUPUT
    name=$(<$OUTPUT)
    # Entra en el case
    case $respose in
      0) echo "hola $name" ;;
      1) echo "Cancel pressed." ;;
      255) echo "[ESC] key pressed."
    esac
    #borrar ese archivo temporal que solo guarda mierda
    rm /tmp/input.txt
    #hace un retorno de la variable
    usuarioAdministradorLDAP=$name
}





# es el menu que se dibuja una y otra vez en bucle hasta que el usuario termine
function dibujarMenu(){
INPUT=/tmp/menu.sh.$$
dialog --clear  --backtitle "Programa parseador" \
--title "[ P R O G R A M A -- P A R S E A D O R ]" \
--menu "Elige las  opciones en orden y asegurate \n\
de tener todo listo antes de empezar \n\
En la parte inferior se ve la cadena que estás componiendo.\n\
Voy a usar el archivo; $nombreArchivoCSV \n\
Y me voy a conectar con las credenciales; dn: cn=$usuarioAdministradorLDAP,dc=$primerparteDominio,dc=$segundaparteDominio. \n\
\n\
Elige una opcón" 20 60 20 \
Nombre "Indica el nombre del admin OpenLDAP" \
Servidor "Indica el nombre del servidor" \
Extension "Indica la extensión del servidor" \
Origencsv "Indica el nombre del fichero CSV a leer" \
Parsear "Crear el archivo .LDIF (no altera el OpenLDAP)" \
Salir "Salir del script" 2>"${INPUT}"

menuitem=$(<"${INPUT}")

echo $menuitem
#sleep 1

case $menuitem in
	Nombre) echo "Elegiste nombre"; llamadaAdialogoNombreAdmin;;
	Servidor) echo "Elegiste servidor"; llamadaAdialogoServidor;;
	Extension) echo "Elegiste extension"; llamadaAdialogoExtension;;
	Origencsv) echo "Elegiste origen"; llamadaAdialogoOrigencsv;;
  Parsear) echo "Realiza el parseado"; parsearElCSV;;
	Salir) echo "Hasta otra";salirDelScript=100;;
esac

}

#bucle principal

while  [ $salirDelScript -eq 10 ]
do
    dibujarMenu;
done
#echo "SALGO DEL SCRIPT"
