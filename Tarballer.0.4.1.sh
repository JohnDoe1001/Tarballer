#!/bin/sh

#debug
set -x

sudo apt-get update
sudo apt-get install whiptail
sudo apt-get upgrade
sudo apt-get check

tarball () {
	echo Welcome to the Tarballer 0.4.1!
	echo Please specifiy the path to your tarball (with root).
	read tar
	while :
		if [[-d $tar]];
		then
			tar -zxvf $tar || tar -jxvf $tar
			./configure
			make
			sudo make install
			if [[$? -ne 0]];
			then
				echo Installation succeed.
			else
				echo Installaton failed.
			fi	
		else
			echo Invalid directory, please try again.
			sleep 3
			clear
			tarballer
}

tarball
