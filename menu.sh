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

function crearUsuarioBasesdedatos()
{
	mysql -u $USER -p < script5.sql
}

function crearbasededatos()
{
	mysql -u $USER -p < script.sql
}



function ejecutarEntornoVirtual()
{
	        	
	
	
	aux=$(aptitude show python3-pip | grep "State: installed")
	aux2=$(aptitude show python3-pip | grep "Estado: instalado")
	aux3=$aux$aux2
	if [ -z "$aux3" ]
	then 
		echo "instalando ..."
		sudo apt-get install python3-pip
	  	
	else
		echo "python3-pip ya estaba instalado iniciando el servicio"
		
	fi
	
	aux=$(aptitude show python3-dev | grep "State: installed")
	aux2=$(aptitude show python3-dev | grep "Estado: instalado")
	aux3=$aux$aux2
	if [ -z "$aux3" ]
	then 
		echo "instalando ..."
		sudo apt-get install python3-dev
	  	
	else
		echo "python3-dev ya estaba instalado iniciando el servicio"
		
	fi
	
	aux=$(aptitude show build-essential | grep "State: installed")
	aux2=$(aptitude show build-essential | grep "Estado: instalado")
	aux3=$aux$aux2
	if [ -z "$aux3" ]
	then 
		echo "instalando ..."
		sudo apt-get install build-essential
	  	
	else
		echo "build-essential ya estaba instalado iniciando el servicio"
		
	fi
	
	aux=$(aptitude show libssl-dev | grep "State: installed")
	aux2=$(aptitude show libssl-dev | grep "Estado: instalado")
	aux3=$aux$aux2
	if [ -z "$aux3" ]
	then 
		echo "instalando ..."
		sudo apt-get install libssl-dev
	  	
	else
		echo "libssl-dev ya estaba instalado iniciando el servicio"
		
	fi
	
	aux=$(aptitude show libffi-dev | grep "State: installed")
	aux2=$(aptitude show libffi-dev | grep "Estado: instalado")
	aux3=$aux$aux2
	if [ -z "$aux3" ]
	then 
		echo "instalando ..."
		sudo apt-get install libffi-dev
	  	
	else
		echo "libffi-dev ya estaba instalado iniciando el servicio"
		
	fi
	
	aux=$(aptitude show python3-setuptools | grep "State: installed")
	aux2=$(aptitude show python3-setuptools | grep "Estado: instalado")
	aux3=$aux$aux2
	if [ -z "$aux3" ]
	then 
		echo "instalando ..."
		sudo apt-get install python3-setuptools
	  	
	else
		echo "python3-setuptools ya estaba instalado iniciando el servicio"
		
	fi
	
	aux=$(aptitude show python3-venv | grep "State: installed")
	aux2=$(aptitude show python3-venv | grep "Estado: instalado")
	aux3=$aux$aux2
	if [ -z "$aux3" ]
	then 
		echo "instalando ..."
		sudo apt-get install python3-venv
	  	
	else
		echo "python3-venv ya estaba instalado iniciando el servicio"
		
	fi
	      
	cd /var/www/formulariocitas
	rm venv
	python3 -m venv venv
	source venv/bin/activate
}


function instalarLibreriasEntornoVirtual()
{	
	cd /var/www/formulariocitas
	source venv/bin/activate
	sudo apt-get update python3-pip
	pip install -r requirements.txt
	
}

function probandotodoconservidordedesarrollodeflask()
{
	python3 formulariocitas/app.py
}


function instalarNGINX()
{
	aux=$(aptitude show NGINX | grep "State: installed")
	aux2=$(aptitude show NGINX | grep "Estado: instalado")
	aux3=$aux$aux2
	if [ -z "$aux3" ]
	then 
		echo "instalando ..."
		sudo apt update
		sudo apt-get install nginx
	else
		echo "NGINX ya estaba instalado iniciando el servicio"
	fi 
}

function arrancarNGINX()
{
	sudo systemctl start nginx
	sudo systemctl status nginx
}

function testearPuertosNGINX()
{	
	sudo apt install net-tools
	sudo netstat -anp | grep nginx
}

function visualizarIndex()
{
	aux=$(which google-chrome | grep "State: installed")
	aux2=$(aptitude show google-chrome | grep "Estado: instalado")
	aux3=$aux$aux2
	if [ which google-chrome ]
	then 
		echo "instalando ..."
		sudo apt update
		sudo apt install wget
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
		sudo dpkg -i google-chrome-stable_current_amd64.deb
		sudo apt-get install -f
	else
		echo "chrome ya estaba instalado iniciando el servicio"
	fi 
	
	google-chrome http://127.0.0.1
}

function personalizarIndex()
{
	sudo mv /home/$USER/index.html /var/www/html/index.nginx-debian.html
	google-chrome http://127.0.0.1

}


function instalarGunicorn()
{
	cd /var/www/formulariocitas
	source venv/bin/activate
	pip install gunicorn
}

function configurarGunicorn()
{	

	cd /var/www/formulariocitas
	rm wsgi.py
	touch wsgi.py
	echo "from app import app" > wsgi.py
	echo 'if __name__ =="__main__":' >> wsgi.py
	echo "	app.run()" >> wsgi.py
	source venv/bin/activate
	gunicorn --bind 127.0.0.1:5001 wsgi:app
	
	
	
	
	
	
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
    echo -e "6 Crear base de datos \n"
    echo -e "7 Ejectuar entorno virtual\n"
    echo -e "8 Instalar las librerias del entorno virtual \n"
    echo -e "9 Probando todo con servidor de desarrollo de flask \n"
    echo -e "10 Instalar NGINX \n"
    echo -e "11 Arrancar NGINX \n" 
    echo -e "12 Testear puertos NGINX \n"
    echo -e "13 Visualizar index \n"
    echo -e "14 Personalizar index \n"
    echo -e "15 Instalar Gunicorn \n"
    echo -e "16 Configurar Gunicorn \n"
    echo -e "26 salir del Menu \n"
    	read -p "Elige una opcion:" opcionmenuppal
    case $opcionmenuppal in
        	0) empaquetaycomprimeFicherosProyecto;;
        	1) eliminarMySQL;;
   	 	2) crearNuevaUbicacion;;
   	 	3) copiarFicherosProyectoNuevaUbicacion;;
   	 	4) instalarMySQL;;
   	 	5) crearUsuarioBasesdedatos;;
   	 	6) crearbasededatos;;
   	 	7) ejecutarEntornoVirtual;;
   	 	8) instalarLibreriasEntornoVirtual;;
   	 	9) probandotodoconservidordedesarrollodeflask;;
   	 	10) instalarNGINX;;
   	 	11) arrancarNGINX;;
   	 	12) testearPuertosNGINX;;
   	 	13) visualizarIndex;;
   	 	14) personalizarIndex;;
   	 	15) instalarGunicorn;;
   	 	16) configurarGunicorn;;
   	 26) salirMenu;;
   	 *) ;;
    esac
done

exit 0

