#!/bin/bash

#Daniel Tejerizo Moretón

#Funcion que comprueba que el usuario existe
function control(){
id "$1" >/dev/null 2>&1
}

#Funcion para sacar el menu
function menu(){
#Menu
echo "Introduce 'a' para añadir un usuario al sistema"
echo "-----------------------------------------------------------------------"
echo "Introduce 'b' para borrar un usuario del sistema"
echo "-----------------------------------------------------------------------"
echo "Introduce 'c' para copiar el directorio personal del usuario en /backup"
echo "-----------------------------------------------------------------------"
echo "Introduce 'g' para mostrar los grupos del usuario por pantalla"
echo "-----------------------------------------------------------------------"

read -p "Introduce lo que quieras hacer: " elemento
}

#Controla que seas root
if [[ $(id -u ) -ne 0 ]]
then
	echo "El script se debe ejecutar como root"
	exit
fi

#El usuario no es una cadena vacia
if [ $1 -z ] &>/dev/null ;then
	echo "Usuario no valido"
	exit
fi

#Sacamos el menu
menu

#Bucle para las opciones
while  [[ $elemento -eq 'a|A|b|B|c|C|g|G' ]] ;do

	case $elemento in
		a) 
		echo "Has elegido la opcion 'a'"
			
		#Ver si el usuario existe
		if control $1;then
			echo "El usuario ya existe"
		else
			#Agregamos el usuario
			useradd -m -s /bin/bash $1
			echo "El usuario " $1 " se ha agregado."
		fi
		break;;
			
		#Controlamos si se pone mayuscula
		A) 
		echo "Has elegido la opcion 'a'"
			
		#Ver si el usuario existe
		if control $1;then
			echo "El usuario ya existe"
		else
			#Agregamos el usuario
			useradd -m -s /bin/bash $1
			echo "El usuario " $1 " se ha agregado."
		fi
		break;;

		b) 
		echo "Has elegido la opcion 'b'"
				
		#Ver si el usuario existe
		if control $1;then
			#Borramos el usuario
			userdel -r $1
			echo "El usuario " $1 " se ha borrado."	
		else
			echo "El usuario no existe"
		fi
		break;;
		
		#Controlamos si se pone mayuscula
		B) 
		echo "Has elegido la opcion 'b'"
			
		#Ver si el usuario existe
		if control $1;then
			#Borramos el usuario
			userdel -r $1
			echo "El usuario " $1 " se ha borrado."	
		else
			echo "El usuario ya existe"
		fi
		break;;
			
		c)
		echo "Has elegido la opcion 'c'"
		
		#Ver si el usuario existe
		if control $1;then
			echo "El usuario " $1 " ya existe."
			if [[ -d /home/backup ]];then
				cp -r /home/$1 /home/backup/
				echo "Se ha copiado el directorio personal de $1 a /backup."
			else
				mkdir /home/backup
				echo "Ruta creada."
				cp -r /home/$1 /home/backup/
				echo "Se ha copiado el directorio personal de $1 a /backup."
				echo "Copia completada."
			fi
			ls -la /home/backup
			echo "Listando el directorio /home/backup."

		else
			echo "El usuario "$1" no existe."
		fi
		break;;
			
		#Controlamos si se pone mayuscula	
		C)
		echo "Has elegido la opcion 'c'"
		
		#Ver si el usuario existe
		if control $1;then
			echo "El usuario " $1 " ya existe."
			if [[ -d /home/backup ]];then
				cp -r /home/$1 /home/backup/
				echo "Se ha copiado el directorio personal de $1 a /backup."
			else
				mkdir /home/backup
				echo "Ruta creada."
				cp -r /home/$1 /home/backup/
				echo "Se ha copiado el directorio personal de $1 a /backup."
				echo "Copia completada."
			fi
			ls -la /home/backup
			echo "Listando el directorio /home/backup."

		else
			echo "El usuario "$1" no existe."
		fi
		break;;
			
		g)
		echo "Has elegido la opcion 'g'"
		
		#Ver si el usuario existe
		if control $1;then
			echo "Los grupos del usuario " $1 " son: "
			groups $1
		else
			echo "El usuario no existe"
		fi
		break;;
		
		#Controlamos si se pone mayuscula
		G)
		echo "Has elegido la opcion 'g'"
		
		#Ver si el usuario existe
		echo "Los grupos del usuario " $1 " son: "
		groups $1
		break;;	
	esac
	
#Si no se mete a, b, c o d
read -p "Introduce lo que quieras hacer: " elemento
done
