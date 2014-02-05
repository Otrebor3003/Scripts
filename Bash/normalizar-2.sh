#!bin/bash

for F in *
do
	echo $F
	nombre=$F
	extension=$(echo $nombre| rev | awk -F "." '{ print $1 }' | rev)
	sinextension=$(echo $nombre | rev | awk -F "." '{$1="";print}'|rev)
	sinextension="$(echo $sinextension | sed -e 's/.*\[.*\]//')"
	nombre="$(echo $sinextension| tr  " *-." _).$extension"
	echo "nombre original $F"
	echo "nombre modificado $nombre"
	read
done
