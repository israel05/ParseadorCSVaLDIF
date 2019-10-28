#!/bin/bash
#crea un dialogo con titulo, tipo mensajito, de 20 de ancho por 40 de largo
dialog --title "Inicio" --msgbox 'Script parseador de CSV a LDIF simplre' 6 30


#un menu con cabeza de página
dialog --begin 10 30 --backtitle "Programa parseador" \
--title "Información" \
--msgbox 'El parseador es un programe en pruebas, no lo use en explotacion.' 10 30


#un menu 
dialog --clear  --help-button --backtitle "Linux Shell Script Tutorial" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 15 50 4 \
Date/time "Displays date and time" \
Calendar "Displays a calendar" \
Editor "Start a text editor" \

menuitem=$(<"${INPUT}")

case $menuitem in
	Date/time) show_date;;
	Calendar) show_calendar;;
	Editor) $vi_editor;;
	Exit) echo "Bye"; break;;
esac
