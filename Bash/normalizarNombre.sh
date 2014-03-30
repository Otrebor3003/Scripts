#!/bin/bash
function normalizarNombre(){
#el argumento es el nombre del fichero que queremos normalizar
#salvo la extensión.
	extension=$(echo "$1"| rev | awk -F "." '{print $1}' | rev)
	echo $extension
	nombre=$(echo "$1" | rev | awk -F "." '{$1="";print}' | rev)
	echo $nombre
	nombre=$(echo "$nombre"| tr  " *-./]/[" _)
	nombre=$(echo "$nombre"|sed -e 's/__*/_/g')
	nombre=$(echo "$nombre"|sed -e 's/_$//g')
	echo "$nombre"
	continuar="si"
	C=1
	normalizado=""
	while [ "$continuar" == "si" ];do
		parte=""
		parte=$(echo $nombre | awk -F "_" '{print $columna}' "columna=$C")
		echo $parte 
		echo "Desea mantener esta columna??"
		read columnas
		if [ $columnas == "si" ]; then
			normalizado+="$parte"
			normalizado+="_"
			echo $normalizado
		fi
		C=$(($C + 1))
		echo "Desea continuar??"
		read continuar
	done
	normalizado=$(echo "$normalizado"|sed -e 's/_$//g')
	echo $normalizado
}


for A in * 
do
	normalizarNombre $A
done
