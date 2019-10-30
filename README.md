# ParseadorCSVaLDIF


<img src="https://i.ibb.co/zGxH7J0/Picture1.png">



Abre un archivo CSV previamente saneado y logra un .LDIF listo para añadir al dominio

Todo esto se podría hacer mediante un script y pasándole los parámetros, pero vamos a ir un poco más allá y a crear un menú gráfico (en ASCII) que lo haga.

La idea detrás de este script de bash es poder crear ususarios en OpenLDAP partiendo de un archivo CSV saneado

Leera frase a frase cada linea de csv
extraera los campos y creaera un solo archivo .ldif con tantos registros como lineas tenga el csv

Mostará los cuatro últimos registros del LDIF creados para que el usuario de un último visto bueno antes de ejecutar la consulta.

Para finalizar hara una llamada a ldapAdd teniendo en cuenta los datos del dominio que el usuario ha facilitado, incluyendo el usuario administrador.


ATENCIÓN: No se ha verificado los errores, no corrige los espacios en blanco, no corrige las tildes, 
no veririfica que el objeto este bien construido, no funciona con CSV no curados. Es solo una idea base para los alumnos de ADSO (SI2)


MEJORAS;
Hacerlo en Python que es un lenguaje más moderno y sencillo
Pasar de dialog a XDialog.


