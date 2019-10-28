#!/bin/bash
# Un script para poder leer entradas
#un archivo temporal donde guardar lo que vamos leyebdo
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

