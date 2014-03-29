#!/bin/bash
function normalizarNombre(){
#el argumento es el nombre del fichero que queremos normalizar
#salvo la extensión.
	extension=$(echo "$1"| rev | awk -F "." '{print $1}' | rev)
	echo $extension
	nombre=$(echo "$1" | rev | awk -F "." '{$1="";print}' | rev)
	echo $nombre
	nombre=$(echo "$nombre"| tr  " *-./]/[" _)
	echo "$nombre"
	echo "numero de columnas que desea mantener"
	read columnas
	let C=1
	normalizado=""
	while [ $C -lt $columnas ]; do
		normalizado+=$(awk -F "-" '{print $C _}')
		
		let C++
	done
	echo $normalizado
}


for A in * 
do
	normalizarNombre $A
done
