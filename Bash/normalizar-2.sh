#/bin/bash
#/bin/bash


function VaciarDirectorios(){
	echo " el argumento es : "$1" y el segundo es "$2""
	for A in * 
	do
		echo "tratando $A"
		if [ -d $A ];then
			echo "Es un directorio"
			if [ "$(ls -A "$A" )" ];then
				echo "entro en $A"
				read
				cd $A
				VaciarDirectorios "$1" "$A"
				echo "Salida -- tratando $A"
			else
				echo "Desea eliminar $A??"
				read respuestaE
				if [ $respuestaE = si ];then
					rmdir $A
				fi
			fi
		else
			echo "no es un directorio"
			if [ "$(pwd)" != "$1" ];then
				echo "saco el fichero $A"
				mv "$A" "$1"
			fi
		fi
		echo "termino de tratar $A"
	done
	echo "Trato el fin del for"
	if [ "$(pwd)" != "$1" ];then
		echo "Desea eliminar $2"
		read respuestaE
		if [ $respuestaE = si ];then	
			cd ..
			rmdir $2
		fi
		
	fi
	return
}

echo "Desea Sacar las Peliculas de los Directorios??"
read respuestav
if [ $respuestav = si ];then
	for B in *
	do
		if [ -d $B ];then
			echo "Desea tratar $B??"
			read res
			if [ $res = si ];then
				argumento=$(pwd)
				cd $B
				VaciarDirectorios "$argumento" "$B"
			fi
		fi
	done	
fi

echo "Desea Trabajar los nombres de las peliculas"
read respuestav
if [ $respuestav = si ];then
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
		Clasificacion=(ACCION BELICA CFICCION COMEDIA DIBUJOS DOCUMENTAL ESPAÑOLA LUCHA MALA NUEVA PINTURA POLICIACA ROMANTICA SUPERHEROES TERROR WESTERN ESPIAS DRAMA)
		echo " Desea moverlo a algun directorio ?"
		read respuestad
		if [ $respuestad = si ];then
			let indice=1
			for i in "${Clasificacion[@]}"
			do
				if [ ! -d "$i" ];then
					mkdir $i
				fi
				echo "$indice  .---------.  $i"
				let indice++
			done
			echo "Seleccione el Directorio Destino"
			read tipo
			let tipo--
			mv $F "${Clasificacion[$tipo]}"
		else
			echo "no modifico el directorio"
		fi		 
	done
fi