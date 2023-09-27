#!/bin/sh

#debug
set -x

sudo apt-get update
sudo apt-get install whiptail
sudo apt-get upgrade
sudo apt-get check

tarball () {
    tar=$(whiptail --inputbox "Please specify the path to the .tar.* file." 10 40 --title "Welcome to the Tarballer 0.5!" 3>&1 1>&2 2>&3)
	while :
		if [[-d $tar]];
		then
			tar -zxvf $tar || tar -jxvf $tar
			./configure
			make
			sudo make install
			if [[$? -ne 0]];
			then
				echo Installation succeed. > good
                whiptail --textbox good 20 25
			else
				echo Installaton failed. > bad
                whiptail --textbox bad 20 25
			fi	
		else
			echo Invalid directory, please try again. > dir
            whiptail --textbox dir 30 35
			clear
			tarballer
}

tarball
