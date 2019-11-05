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
retornoLlamadaAdialogo=$name
}





#un menu 

INPUT=/tmp/menu.sh.$$


dialog --clear  --backtitle "Programa parseador" \
--title "[ P R O G R A M A -- P A R S E A D O R ]" \
--menu "Ve eligiendo las diferentes opciones en orden y asegurate \n\
de tener todo listo antes de empezar \n\
En la parte superior se ve la cadena que estás componiendo.\n\
Voy a usar el archivo; $nombreArchivoCSV \n\
Y me voy a conectar con las credenciales; dn: cn=$usuarioAdministradorLDAP,dc=$primerparteDominio,dc=$segundaparteDominio. \n\
\n\
Elige una opcón" 20 60 20 \
Nombre "Indica el nombre del admin OpenLDAP" \
Servidor "Indica el nombre del servidor" \
Extension "Indica la extensión del servidor" \
Origencsv "Indica el nombre del fichero CSV a leer" \
Salir "Salir del script" 2>"${INPUT}"

menuitem=$(<"${INPUT}")

echo $menuitem
sleep 1

case $menuitem in
	Nombre) echo "Elegiste nombre";;
	Servidor) echo "Elegiste servidor";;
	Extension) echo "Elegiste extension";;
	Origencsv) echo "Elegiste origen"; llamadaAdialogoOrigencsv;;
	Exit) echo "Bye"; break;;
esac

echo "FINAL"
echo $retornoLlamadaAdialogo
