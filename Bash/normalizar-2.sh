#/bin/bash
function VaciarDirectorios(){
	for A in *
	do
		if [ -d $A ];then
			if [ "$(ls -A $DIR)" ]; then
				echo "entro en $A"
				read
				cd $A
				VaciarDirectorios()
			else	
				echo "elimino $A"
				read
				rmdir $A
			fi
		else
			mv $A ..
		fi
	done
	echo "bajo un nivel"
	read
	cd ..
	return
{

echo "Desea Sacar las Peliculas de los Directorios??"
read respuestav
if [ $respuestav = si ];then
	
	for F in *
	do
		if [ -d $F ];then	
			echo "Desea tratar  $F  ?? si/no"
			read respuestav2
			if [ $respuestav2 = si ];then
				cd $F
				for F in *
					if [ -d $F ];then
						echo "es un subdirectorio se ignora"
					else
						mv $F ..
					fi
				done
				cd ..
			fi
		fi
	done	

fi

for F in *
do
	echo $F
	nombre=$F
	extension=$(echo $nombre| rev | awk -F "." '{ print $1 }' | rev)
	sinextension=$(echo $nombre | rev | awk -F "." '{$1="";print}'|rev)
	sinextension="$(echo $sinextension | sed -e 's/.*\[.*\]//')"
	nombre="$(echo $sinextension| tr  " *-." _).$extension"
	echo "-----------"
	echo "nombre original $F"
	echo "nombre modificado $nombre"
	echo "¿Desea Modificar el archivo? si/no"
	echo "-----------"
	read respuesta
	if [ $respuesta = si ];then
		echo "modifico"
		mv $F $nombre
	else
		echo "no modifico"
	fi
	echo " Desea moverlo a algun directorio ?"
	read respuestad
	if [ $respuestad = si ];then

			echo " listado "
			echo " 1.	 ACCION"
			echo " 2.	 BELICA"
			echo " 3.	 CFICCION"
			echo " 4.	 COMEDIA"
			echo " 5.	 DIBUJOS"
			echo " 6.	 DOCUMENTAL"
			echo " 7.	 ESPAÑOLA"
			echo " 8.	 LUCHA"
			echo " 9.	 MALA"
			echo " 10. 	 NUEVA"
			echo " 11. 	 PINTURA"
			echo " 12.	 POLICIACA"
			echo " 13.	 ROMANTICA"
			echo " 14.	 SUPERHEROES"
			echo " 15.	 TERROR"
			echo " 16.	 WESTERN"
			echo " 17.	 ESPIAS"
			echo " 18.	 DRAMA"
		echo "-------------------------"
		echo "Seleccione el Directorio Destino"
		read tipo
		case $tipo in
			1 ) 
			mv $nombre ACCION
			;;
			2 )
			 mv $nombre BELICA
			;;
			3)
			 mv $nombre CFICCION
			;;
			4)
			 mv $nombre COMEDIA
			;;
			5)
			 mv $nombre DIBUJOS
			;;
			6)
			 mv $nombre DOCUMENTAL
			;;
			7)
			 mv $nombre ESPAÑOLA
			;;
			8)
			 mv $nombre LUCHA
			;;
			9)
			 mv $nombre MALA
			;;
			10)
			 mv $nombre NUEVA
			;;
			11)
			 mv $nombre PINTURA
			;;
			12)
			 mv $nombre POLICIACA
			;;
			13)
			 mv $nombre ROMANTICA
			;;
			14)
			 mv $nombre SUPERHEROES
			;;
			15)
			 mv $nombre TERROR
			;;
			16)
			 mv $nombre WESTERN
			;;
			17)
			 mv $nombre ESPIAS
			;;
			18)
			 mv $nombre DRAMA
			;;
		esac
		else
			echo "no modifico el directorio"
		fi		 
done
