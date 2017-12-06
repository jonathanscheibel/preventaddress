#!/bin/bash

#Versao: 2017.12.06

#Devs
# Jonathan Scheibel - jonathansmorais@gmail.com - https://www.linkedin.com/in/jonathan-scheibel/

#Sobre:
# Um script para verificação de seu endereco em tempo real. 
# O mesmo desconecta-te em casos de exposicao.

NAME_APPLICATION="checkAddress";
URL_SERVICE="https://start.parrotsec.org/ip/"

function checkMyAddress  {
	echo "$NAME_APPLICATION - Verificando exposicao de endereco..."
	while true
	do
		 myIp=`wget -qO- $URL_SERVICE`
		 echo $myIp | grep $2 >> /dev/null
		 if [ "$?" == "0" ]; then		 	
		 	ifconfig $1 down		 	
		 	echo "$NAME_APPLICATION - Endereco exposto! Dispositivo derrubado!"
		 	exit 45
		 fi
		 echo -n .
		 
	done
}
	
if [ `whoami` == 'root' ]; then	
	if [ "$1" == "" ]; then
		clear
		echo "$NAME_APPLICATION - DISPOSITIVOS DE REDE:"
		ip a | grep "<"
		myIp=`wget -qO- $URL_SERVICE`
		echo "$NAME_APPLICATION - ENDERECO ATUAL:  $myIp "	
		echo "$NAME_APPLICATION - EXEMPLO DE UTILIZACAO: "
		echo "#nohup ./$NAME_APPLICATION .sh eth0 $myIp &"
	else
		checkMyAddress $1 $2
	fi
else
	echo "checkAddress - Entre como root para utilizar a ferramenta!"
	exit 1
fi