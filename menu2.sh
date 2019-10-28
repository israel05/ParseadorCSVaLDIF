#!/bin/bash
#crea un dialogo con titulo, tipo mensajito, de 20 de ancho por 40 de largo
#dialog --title "Inicio" --msgbox 'Script parseador de CSV a LDIF simplre' 6 30


#un menu con cabeza de página
#dialog --begin 10 30 --backtitle "Programa parseador" \
#--title "Información" \
#--msgbox 'El parseador es un programe en pruebas, no lo use en explotacion.' 10 30

#un menu 

let menuitem

dialog --clear  --backtitle "Programa parseador" \
--title "[ P R O G R A M A -- P R I N C I P A L ]" \
--menu "Ve eligiendo las diferentes opciones y asegurate \n\
de tener todo listo antes de empezar \n\
Es aconsajable ir en orden.\n\
Elige una opcón" 20 60 20 \
Nombre "Indica el nombre del admin OpenLDAP" \
Servidor "Indica el nombre del servidor" \
Extension "Indica la extensión del servidor" \
Origencsv "Indica el nombre del fichero CSV a leer" \
# Salir "Salir del script" 2>"${INPUT}"

menuitem=$?

echo $menuitem
sleep 1

case $menuitem in
	Nombre) echo "Elegiste nombre";;
	Servidor) echo "Elegiste servidor";;
	Extension) echo "Elegiste extension";;
	Origencsv) echo "Elegiste origen";;
	Exit) echo "Bye"; break;;
esac
