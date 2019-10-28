#!/bin/bash
# Demo-menu shell script
## ----------------------------------
# Define variables
# ----------------------------------
EDITOR=nano
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'
#variables para guardar lo leido sobre el usuario LDAP
let dominio
let extension
let admin
 
# ----------------------------------
# User defined function
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

one(){
	echo "Opción uno, indica el nombre del dominio"
	read dominio
        pause
}
 
# do something in two()
two(){
	echo "Opción dos, indica la extension del dominio"
	read extension
        pause
}

# do something in two()
three(){
	echo "Opción tres, indica el nombre del admin del dominio"
	read admin
        pause
}
 
# function to display menus dibuja un menu feo de linea de comandos, solo es eso
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo "  MENU-SOLOLINUX.ES  "
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "Bienvenido $admin al dominio $dominio.$extension"
	echo "1. Indicar nombre dominio"
	echo "2. Indicar extension del dominio"
	echo "4. Indicar el nombre del admini de OPENLDAP"
	echo "0. Exit"
}
# Lee la accion sobre el teclado y la ejecuta.
# Invoca el () cuando el usuario selecciona 1 en el menú.
# Invoca a los dos () cuando el usuario selecciona 2 en el menú.
# Salir del menu cuando el usuario selecciona 3 en el menú.
read_options(){
	#creo una variable local, vive dentro de esta funcion y nada mas
	local choice
	#leo el teclado mostrando antes un mensaje y lo leido lo guardo en choice	
	read -p "Enter choice [ 1 - 0] " choice
	# en caso de que choice valga
	case $choice in

		1) one ;; #lanzo la funcion one
		2) two ;; #lanzo la funcio two
		3) three ;;
		0) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 #todo lo demas produce un error
	esac #fin del case
}
 
# -----------------------------------
# Main logic - infinite loop
# ------------------------------------
while true
do
 
	show_menus #dibujo el menu
	read_options #leo la opcion del menu
done
