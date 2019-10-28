#!/bin/bash
#crea un dialogo con titulo, tipo mensajito, de 20 de ancho por 40 de largo
#dialog --title "Inicio" --msgbox 'Script parseador de CSV a LDIF simplre' 6 30


#un menu con cabeza de página
#dialog --begin 10 30 --backtitle "Programa parseador" \
#--title "Información" \
#--msgbox 'El parseador es un programe en pruebas, no lo use en explotacion.' 10 30


let retornoLlamadaAdialogo
function llamadaAdialogo(){
OUTPUT="/tmp/input.txt"

# Dibuja el InpuntBox
dialog --title "El nombre del admin LDAP" \
--backtitle "Parseador de CSV a LDIP" \
--inputbox "Indica el nombre del admin LDAP (suele ser admin)" 8 60 2>$OUTPUT

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
--title "[ P R O G R A M A -- P R I N C I P A L ]" \
--menu "Ve eligiendo las diferentes opciones y asegurate \n\
de tener todo listo antes de empezar \n\
Es aconsajable ir en orden.\n\
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
	Origencsv) echo "Elegiste origen"; llamadaAdialogo;;
	Exit) echo "Bye"; break;;
esac

echo "FINAL"
echo $retornoLlamadaAdialogo
