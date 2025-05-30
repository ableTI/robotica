#! /bin/bash
echo 'Welkom to the robosoccer installment script!'

#check sudo
if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi
#check internet connection
wget -q --spider https://github.com
if [ $? -eq 0 ]; then
    echo 'Internet connection found'
else
    echo 'Error, either your device is off-line or https://github.com is off-line.'
    exit
fi

#installation options
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
echo 'You will now need to select what this script should configure.'
read -p 'Do you want to install  a desktop enviorment(grapical display support)?' DE
read -p 'Do you want to install arduino IDE version one and two?' ard
read -p 'Do you want to install and configure git?' git
while true; do
    read -p 'Do you want to clone the robosoccer git repository? [Y]es or [N]o' gitrep
    case $gitrep in
        y*|Y*)
            while true; do
                read -p "Where do you wish to install the robosoccer repository? (Default: /home/$user/Documents/)" gitreploc
                case $gitreploc in
                    "")
                        echo 'Left empty, using default folder.'
                        gitreploc="/home/$user/Documents/"
                        if [ -d "/home/$user/Documents/" ]; then
                            break
                        fi
                        read -p "/home/$user/Documents/ does not exist or is an file, do you wish to create this folder?" inp3
                        case $inp3 in
                            y*|Y*)
                                mkdir "$gitreploc"
                                if [ -d "$gitreploc" ]; then
                                    echo "Somthing went wrong with the creation of the directory, exiting"
                                    exit
                                fi
                                break
                                ;;
                           n*|N*)
                                echo "Will not clone git repository"
                                gitrep=N
                                break
                                ;;
                           *)
                                echo "Did not recognize input please retry"
                                ;;
                        esac
                        ;;
                    *)
                        if [ -d "$gitreploc" ]; then
                            echo "Using $gitreploc."
                            break
                        fi
                        read -p "$gitreploc does not exist or is an file, do you wish to create this folder?" inp2
                        case $inp2 in
                            y*|Y*)
                                mkdir "$gitreploc"
                                if [ -d "$gitreploc" ]; then
                                    echo "Somthing went wrong with the creation of the directory, exiting"
                                    exit
                                fi
                                ;;
                            n*|N*)
                                echo "Will not clone git repository"
                                gitrep=N
                                break
                                ;;
                            *)
                                echo "Did not recognize input please retry"
                                ;;
                        esac
                        ;;
                esac
            done
            break
            ;;
        n*|N*)
            echo 'Selected no.'
            break
            ;;
        *)
            echo 'Unrecognised input, please try again'
            ;;
    esac
done

#setup DE
apt install xfce4-goodies xfce4 lightdm xscreensaver xscreensaver-data xscreensaver-data-extra xscreensaver-gl xscreensaver-gl-extra xscreensaver-screensaver-bsod xscreensaver-screensaver-dizzy xscreensaver-screensaver-webcollage supertuxkart -y
wget https://github.com/mendelcollege-robotics/robotica/blob/main/setup/xscreensaver.desktop -O /etc/xdg/autostart/xscreensaver.desktop
apt remove gnome-screensaver
wget https://github.com/mendelcollege-robotics/robotica/blob/main/setup/.xscreensaver -O "/home/$user/.xscreensaver"


#install arduino ide
apt install arduino usbutils unzip wget -y
wget https://downloads.arduino.cc/arduino-ide/nightly/arduino-ide_nightly-20250529_Linux_64bit.zip -O /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip
unzip /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip -d /usr/share/arduino-ide_nightly-20250529_Linux_64bit
rm /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip
wget https://github.com/mendelcollege-robotics/robotica/blob/main/setup/arduino2.desktop -O /usr/share/applications/arduino2.desktop

#install openMV IDE
apt install usbutils -y
wget https://github.com/openmv/openmv-ide/releases/download/development/openmv-ide-linux-x86_64-4.6.1.tar.gz -O /tmp/openmv.tar.gz
tar -xzf /tmp/openmv.tar.gz --directory /tmp/
sh /tmp/openmv-ide/setup.sh
rm /tmp/openmv.tar.gz
rm -rf /tmp/openmv-ide/

#setup GIT
apt install git -y
    #secure download method
gpg --import ./secrets/public.key
gpg --import ./secrets/private.key
mkdir -p "/home/$user/.ssh/"
cp ./secrets/ssh-robosoccer "/home/$user/.ssh/ssh-robosoccer"
cp ./secrets/ssh-robosoccer.pub "/home/$user/.ssh/ssh-robosoccer.pub"
sudo -u $user "git config --global user.signingkey 08242B7544C76B9E9B4EFB91C6C9DC589850AB7D"
wget https://github.com/mendelcollege-robotics/robotica/blob/main/setup/.gitmessage.txt -O /home/$user/.gitmessage.txt
sudo -u $user  "git config --global commit.template ~/.gitmessage.txt"

#download git repo
sudo -u $user "git clone git@github.com:mendelcollege-robotics/robotica.git $gitreploc"

