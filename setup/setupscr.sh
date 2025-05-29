#! /bin/bash
echo "Welkom to the robosoccer installment script!"

#check sudo
if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi
#check internet connection
wget -q --spider https://github.com
if [ $? -eq 0 ]; then
    echo "Internet connection found"
else
    echo "Error you device seems to be off-line."
    exit
fi
wget -q --spider https://abeltim.com
if [ $? -eq 0 ]; then
    echo "route to abeltim.com OK"
else
    echo "Error you abeltim.com seems to be unreachable please contact contact@abeltim.com"
    exit
fi
#select user
echo "Please enter the username of the user it must be installed for."
read -p "Username: " user
if id -u "$user" >/dev/null 2>&1; then
    echo " "
else
    echo "$user"' does not exist'
    while true; do
        read -p "Do you wich to create this user [Y]es or [N]o " inp1
        case $inp1 in
            y*|Y*)
                echo 'creating user'
                break
                ;;
            n*|N*)
                echo 'No, exiting'
                exit
                ;;
            *)
            echo 'Unrecognised input, please try again'
            ;;
        esac
    done
    useradd $user
fi


#install packages
apt install arduino xfce4-goodies xfce4 lightdm xscreensaver xscreensaver-data xscreensaver-data-extra xscreensaver-gl xscreensaver-gl-extra xscreensaver-screensaver-bsod xscreensaver-screensaver-dizzy xscreensaver-screensaver-webcollage git wget curl usbutils supertuxkart sed unzip -y

#setup screen

#install arduino ide
wget https://downloads.arduino.cc/arduino-ide/nightly/arduino-ide_nightly-20250529_Linux_64bit.zip -O /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip
unzip /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip -d /usr/share/arduino-ide_nightly-20250529_Linux_64bit
rm /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip
wget https://abeltim.com/robotica/arduino2.desktop -O /usr/share/applications/arduino2.desktop

#install openMV IDE
wget https://github.com/openmv/openmv-ide/releases/download/development/openmv-ide-linux-x86_64-4.6.1.tar.gz -O /tmp/openmv.tar.gz
tar -xzf /tmp/openmv.tar.gz --directory /tmp/
su sh /tmp/openmv-ide/setup.sh
rm /tmp/openmv.tar.gz
rm -rf /tmp/openmv-ide/

#setup GIT

#download git repo


stty -echo
printf "Password: "
read PASSWORD
stty echo
printf "\n"
