#!/bin/bash
 
FolderName="/lib/plymouth/themes/Deliss-Molang/"
Destination="/lib/plymouth/themes"

if [ -d $FolderName ]
then
	echo "Ignorando Instalacion, el Directorio existe.."
	
else
	sudo aptitude install plymouth-x11 plymouth-theme-script -y	
	echo "Iniciando Instalacion..."
	sudo cp -R Deliss-Molang $Destination
	
fi

	echo "Ingrese el numero del nuevo Plymouth ( Pantalla de Inicio )"
	echo ""
	echo "Nombre		Numero"	
	echo "Default		   0"
	echo "Molang 		   1"
	echo "Cancelar          Otro"
	echo "---Eleccion:"	
	read number

case $number in
	1)
	   sudo rm "$Destination/default.plymouth"
	   sudo ln -s "$Destination/Deliss-Molang/Deliss-Molang.plymouth" /lib/plymouth/themes/default.plymouth
	   sudo update-initramfs -u
	;;

	0)

 	   sudo rm "$Destination/default.plymouth"
	   sudo ln -s "$Destination/ubuntu-logo/ubuntu-logo.plymouth" /lib/plymouth/themes/default.plymouth
	   sudo update-initramfs -u
	;;

	*)
	   echo "Saliendo..."
	exit 0
	;;

esac

	echo "Listo  ^^, ¿Ver cambios? (si/no)"
	read selec
case $selec in

	yes|si|SI|Si|s|S|y|Y)
	  sudo plymouthd --debug --debug-file=/tmp/plymouth-debug-out ; sudo plymouth --show-splash ; for ((I=0;I<10;I++)); do sleep 1 ; sudo plymouth --update=event$I ; done ; sudo plymouth --quit

	;;

	*)
	;;

esac
	echo "Saliendo"

