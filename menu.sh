#!/usr/bin/bash
function empaquetaycomprimeFicherosProyecto()
{
  cd /home/$USER/formulariocitas
  tar cvzf  /home/$USER/formulariocitas.tar.gz app.py script.sql requirements.txt templates/*
}
function eliminarMySQL()
{
#Para el servicio
sudo service mysql stop
#Elimina los paquetes +ficheros de configuración + datos
sudo apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
#servidor MySQL se desinstale completamente sin dejar archivos de residuos.
sudo apt-get autoremove
#Limpia la cache
sudo apt-get autoclean
#Para cerciorarnos de que queda todo limpio:
#Eliminar los directorios de datos de MySQL:
sudo rm -rf /var/lib/mysql
#Eliminar los archivos de configuración de MySQL:
sudo rm -rf /etc/mysql/
#Eliminar los logs
sudo rm -rf /var/log/mysql
}

function crearNuevaUbicacion()
{
    if [ -d /var/www/formulario ]
    then
        echo -e "Ya existe el direcctorio...\n"
    else
        echo "Creando directorio..."
        sudo mkdir -p /var/www/formulariocitas
        echo "Cambiando permisos del directorio..."
        sudo chown -R $USER:$USER /var/www/formulariocitas
        echo ""
        read -p "PULSA ENTER PARA CONTINUAR..."
    fi
}
function copiarFicherosProyectoNuevaUbicacion()
{
if test -e "/home/$USER/formulariocitas.tar.gz" ; then
	cd /var/www/formulariocitas
	tar xvzf "/home/$USER/formulariocitas.tar.gz"
else
	echo "no existe el comprimido"
fi
}

function instalarMySQL()
{
aux=$(aptitude show mySQL | grep "State: installed")
aux2=$(aptitude show mySQL | grep "Estado: instalado")
aux3=$aux$aux2
if [ -z "$aux3" ]
	then 
		echo "instalando ..."
		sudo apt-get install mysql-server
	  	sudo systemctl start mysql.service
	else
		echo "mySQL ya estaba instalado iniciando el servicio"
		sudo systemctl start mysql.service
	fi 
}

function crear_usuario_basesdedatos()
{

}

function salirMenu()
{
echo "Fin del Programa"
}
### Main ###
opcionmenuppal=0
while test $opcionmenuppal -ne 26
do
    #Muestra el menu
    echo -e "0 Empaqueta y comprime los ficheros clave del proyecto"
    echo -e "1 Eliminar la instalación de mysql\n"
    echo -e "2 Crea la nueva ubicación \n"
    echo -e "3 Copiar ficheros proyecto nueva ubicación \n"
    echo -e "4 Instalar mySQL \n"
    echo -e "5 Crear usuario Bases de Datos \n"
    echo -e "26 salir del Menu \n"
    	read -p "Elige una opcion:" opcionmenuppal
    case $opcionmenuppal in
        	0) empaquetaycomprimeFicherosProyecto;;
        	1) eliminarMySQL;;
   	 2) crearNuevaUbicacion;;
   	 26) salirMenu;;
   	 *) ;;
    esac
done

exit 0

