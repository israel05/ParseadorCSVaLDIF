# ParseadorCSVaLDIF
Abre un archivo CSV previamente saneado y logra un .LDIF listo para añadir al dominio


La idea detrás de este script de bash es poder crear ususarios en OPenLDAP partiendo de un archivo CSV saneado

Leera frase a frase cada linea de csv
extraera los campos y creaera un solo archivo .ldif con tantos registros como lineas tenga el csv


ATENCIÓN: No se ha verificado los errores, no corrige los espacios en blanco, no corrige las tildes, 
no veririfica que el objeto este bien construido. Es solo una idea base
