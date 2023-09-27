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
	do
		if [[ -d $tar ]];
		then
                        a=$("cd $tar || exit")
			b=$(tar -zxvf "$tar" || tar -jxvf "$tar")
			c=$(./configure)
			d=$(make)
			e=$(sudo make install)
                        whiptail --gauge "Redirecting to the dỉrectory..." 15 80 "$a"
			whiptail --gauge "Untar in progress..." 15 80 "$b"
                        whiptail --gauge "Configuring..." 15 80 "$c"
			whiptail --gauge "Compiling..." 15 80 "$d"
                        whiptail --gauge "Installing..." 15 80 "$e"
			whiptail --msgbox "Installation completed!" 40 40
			if [[ $? -ne 0 ]];
			then
				echo "No error found! Good for you!" > good
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
        	fi
        done
}

tarball
