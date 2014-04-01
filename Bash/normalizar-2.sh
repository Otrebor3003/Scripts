#/bin/bash
#/bin/bash


function VaciarDirectorios(){
	echo " el argumento es : "$1" y el segundo es "$2""
	for A in * 
	do
		echo "tratando $A"
		if [ -d "$A" ];then
			echo "Es un directorio"
			if [ "$(ls -A "$A" )" ];then
				echo "entro en $A"
				read
				cd "$A"
				VaciarDirectorios "$1" "$A"
				echo "Salida -- tratando $A"
			else
				echo "Desea eliminar "$A"??"
				read respuestaE
				if [ $respuestaE = si ];then
					rmdir "$A"
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
			rmdir "$2"
		fi
		
	fi
	return
}
function normalizarNombre(){
#el argumento es el nombre del fichero que queremos normalizar
#salvo la extensión.
	extension=$(echo "$1"| rev | awk -F "." '{print $1}' | rev)
	echo $extension
	nombre=$(echo "$1" | rev | awk -F "." '{$1="";print}' | rev)
	nombre=$(echo "$nombre"| tr  " *-./]/[" _)
	nombre=$(echo "$nombre"|sed -e 's/__*/_/g')
	nombre=$(echo "$nombre"|sed -e 's/_$//g')
	echo "$nombre"
	continuar="si"
	C=1
	normalizado=""
	ncolumnas=$(echo $nombre|awk -F "_" '{print NF}')
	if [ $ncolumnas -gt 1 ];then
		while [[ "$continuar" == "si" && $C -le $ncolumnas ]];do
			parte=""
			parte=$(echo $nombre | awk -F "_" '{print $columna}' "columna=$C")
			echo $parte 
			echo "Desea mantener esta columna??"
			read columnas
			if [ $columnas == "si" ]; then
				normalizado+="$parte"
				normalizado+="_"
				#echo $normalizado
			fi
			C=$(($C + 1))
			if [ $C -lt $ncolumnas ];then
				echo "Desea continuar??"
				read continuar
			fi
		done
		normalizado=$(echo "$normalizado"|sed -e 's/_$//g')
	else
		normalizado=$nombre
	fi
	normalizado="$normalizado.$extension"
	echo "resultado final: $normalizado"
	echo "desea ejecutar el cambio de nombre"
	read ejecutar
	if [ $ejecutar == "si" ];then
		mv "$1" "$normalizado" 
	fi
	
}

echo "Desea Sacar las Peliculas de los Directorios??"
read respuestav
if [ $respuestav = si ];then
	for B in *
	do
		if [ -d "$B" ];then
			echo "Desea tratar $B??"
			read res
			if [ $res = si ];then
				argumento=$(pwd)
				cd "$B"
				VaciarDirectorios "$argumento" "$B"
			fi
		fi
	done	
fi
echo "Desea tratar los nombres de las películas"
read respuestav
if [ $respuestav == "si" ];then
	for F in *
	do
		echo $F
		if [ ! -d "$F" ];then
			echo "Desea tratar este nombre?"
			read tnombre
			if [ $tnombre == "si" ];then
				normalizarNombre "$F"
			fi
		fi
	done
fi

echo "Desea organizar las peiculas por directorios"
read respuestav
if [ $respuestav = si ];then
	for F in *
	do
		if [ ! -d "$F" ];then
			echo $F
			Clasificacion=(ACCION BELICA CFICCION COMEDIA DIBUJOS DOCUMENTAL ESPAÑOLA LUCHA MALA NUEVA PINTURA POLICIACA ROMANTICA SUPERHEROES TERROR WESTERN ESPIAS DRAMA)
			echo " Desea moverlo a algun directorio ?"
			read respuestad
			if [ $respuestad = si ];then
				let indice=1
				for i in "${Clasificacion[@]}"
				do
					if [ ! -d "$i" ];then
						mkdir "$i"
					fi
					echo "$indice  .---------.  $i"
					let indice++
				done
				echo "Seleccione el Directorio Destino"
				read tipo
				let tipo--
				echo mv "$F" "${Clasificacion[$tipo]}"

			else
				echo "no modifico el directorio"
			fi
		fi		 
	done
fi