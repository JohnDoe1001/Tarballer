#!/bin/sh

sudo apt-get update
sudo apt-get install whiptail
sudo apt-get upgrade
sudo apt-get check

tar_gui () {
    tar=$(whiptail --inputbox "Please specify the path to the .tar.* file." 10 40 --title "Welcome to the Tarballer 1.1!" 3>&1 1>&2 2>&3)
    echo "$tar"
	while x=1:
	do
                x=$x+1
		if [ -d "$tar" ];
		then
            a=$(cd "$tar")
			b=$(sudo mkdir ./$RANDOM)
		    c=$(tar -C ./"$b" -zxvf "$tar" || tar -C ./"$b" -jxvf "$tar" || tar -C ./"$b" -xzvf "$tar")
			d=$(./configure)
			e=$(make)
			f=$(sudo make install)
            g=$(sudo rm -d ./"$b")
            whiptail --gauge "Redirecting to the dỉrectory..." 15 80 "$a"
			whiptail --gauge "Creating temporary directory..." 15 80 "$b"
			whiptail --gauge "Decompressing..." 15 80 "$c"
            whiptail --gauge "Configuring..." 15 80 "$d"
			whiptail --gauge "Compiling..." 15 80 "$e"
            whiptail --gauge "Installing..." 15 80 "$f"
			whiptail --gauge "Finishing installation..." 15 80 "$g"
			whiptail --msgbox "Installation completed!" 40 40)
			if [ $? -eq 0 ]
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
			tar_gui
        	fi
        done
exit
}

# for debugging purposes
tar_cli () {
echo "Welcome to the Tarballer 1.2!"
echo "Please specify the path to the .tar.* file."
read -r tarcli
	while x=1:
 	do
                x=$x+1
  		if [ -d "$tarcli" ];
		then
  			cd "$tar" || exit
                        tmptar=$(sudo mkdir ./$RANDOM)
  			tar -C ./"$tmptar" -zxvf "$tar" || tar -C ./"$tmptar" -jxvf "$tar" || tar -C ./"$tmptar" -xzvf "$tar"
  			./configure
  			make
  			sudo make install
                        sudo rm -d ./"$tmptar"
     			if [ $? -eq 0 ];
			    then
				echo "No error found! Good for you!"
    			else
				echo "Installaton failed."
    			fi
       		else
			echo Invalid directory, please try again.
   		fi
	done
 exit
}

prompt=$(whiptail --title "Choose an interface to continue." --menu "Choose an interface" 30 30 5 \
"Normal" "GUI" \
"Debug mode" "CLI" \
"Exit" 3>&1 1>&2 2>&3)
case $prompt in
("Normal") tar_gui ;;
("Debug mode") tar_cli ;;
("Exit") exit ;;
esac
