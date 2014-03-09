function normalizarNombre(){
#el argumento es el nombre del fichero que queremos normalizar
#salvo la extensión.
	extension=$(echo "$1"| rev | awk -F "." '{print $1}' | rev)
	echo $extension

}

for i in * do
	normalizarNombre $i

done