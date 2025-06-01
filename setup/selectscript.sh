#! /bin/bash
echo 'Welkom to the robosoccer guided installment script!'

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
        read -p "Do you wich to create this user? [Y]es or [N]o:  " inp1
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
while true; do
    read -p 'Do you want to install a desktop enviorment(grapical display support)? [Y]es or [N]o:  ' DE
    case $DE in
        Y*|y*)
            break
            ;;
        n*|N*)
            break
            ;;
        *)
            echo "Did not recognize input please retry"
            ;;
    esac
done
while true; do
    read -p 'Do you want to install xscreesaver? [Y]es or [N]o:  ' xscr
    case $xscr in
        Y*|y*)
            break
            ;;
        n*|N*)
            break
            ;;
        *)
            echo "Did not recognize input please retry"
            ;;
    esac
done
while true; do
    read -p 'Do you want to install arduino IDE version one and two? [Y]es or [N]o:  ' ard
    case $ard in
        Y*|y*)
            break
            ;;
        n*|N*)
            break
            ;;
        *)
            echo "Did not recognize input please retry"
            ;;
    esac
done
while true; do
    read -p 'Do you want to install openMV IDE? [Y]es or [N]o:  ' omv
    case $omv in
        Y*|y*)
            break
            ;;
        n*|N*)
            break
            ;;
        *)
            echo "Did not recognize input please retry"
            ;;
    esac
done
while true; do
    read -p 'Do you want to install and configure git? [Y]es [N]o:  ' git
    case $git in
        Y*|y*)
            read -p 'Please enter location of the secret file (secrets.tar.gz.gpg): ' secloc
            if [ -f $secloc ]; then
                echo "File found!"
                break
            fi
            echo "File $secloc not found!"
            read -p "Is the file on an external drive? [Y]es or [N]o:  " inp4
            case $inp4 in
                Y*|y*)
                    fdisk -l
                    read -p "Please enter the drive where the secrets are located.[/dev/sdXN](where x is an letter and N an number):  " drv
                    mkdir /mnt/secdrive
                    mount $drv /mnt/secdrive
                    echo "The external drive is now mounted at /mnt/secdrive, please cd into it and locate where the secrets.tar.gz.gpg file is located. After this you can rerun the script."
                    exit
                    ;;
                n*|N*)
                    echo "In that case i can not help you."
                    read -p "Do you still wich to configure git? [Y]es [N]o:  " git
                    ;;
                *)
                    echo "Did not recognize input please retry"
                    ;;
            esac
            ;;
        n*|N*)
            break
            ;;
        *)
            echo "Did not recognize input please retry"
            ;;
    esac
done
while true; do
    read -p 'Do you want to clone the robosoccer git repository? [Y]es or [N]o' gitrep
    case $gitrep in
        y*|Y*)
            while true; do
                read -p "Where do you wish to install the robosoccer repository? (Default: /home/$user/Documents/):  " gitreploc
                case $gitreploc in
                    "")
                        echo 'Left empty, using default folder.'
                        gitreploc="/home/$user/Documents/"
                        if [ -d "/home/$user/Documents/" ]; then
                            break
                        fi
                        read -p "/home/$user/Documents/ does not exist or is an file, do you wish to create this folder? [Y]es or [N]o:  " inp3
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

apt install cowsay sl lolcat fortune -y

#setup DE
case $DE in
    Y*|y*)
        apt install xfce4-goodies xfce4 lightdm -y
        ;;
esac
#setup xscreensaver
case $xscr in
    Y*|y*)
        apt install xscreensaver xscreensaver-data xscreensaver-data-extra xscreensaver-gl xscreensaver-gl-extra xscreensaver-screensaver-bsod xscreensaver-screensaver-dizzy xscreensaver-screensaver-webcollage supertuxkart -y
        wget https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/xscreensaver.desktop -O /etc/xdg/autostart/xscreensaver.desktop
        apt remove gnome-screensaver
        wget https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/.xscreensaver -O "/home/$user/.xscreensaver"
        ;;
esac

#install arduino ide
case $DE in
    Y*|y*)
        apt install arduino usbutils unzip wget -y
        wget https://downloads.arduino.cc/arduino-ide/nightly/arduino-ide_nightly-20250529_Linux_64bit.zip -O /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip
        unzip /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip -d /usr/share/arduino-ide_nightly-20250529_Linux_64bit
        rm /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip
        wget https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/arduino2.desktop -O /usr/share/applications/arduino2.desktop
        ;;
esac

#install openMV IDE
case $omv in
    Y*|y*)
        apt install usbutils -y
        wget https://github.com/openmv/openmv-ide/releases/download/development/openmv-ide-linux-x86_64-4.6.1.tar.gz -O /tmp/openmv.tar.gz
        tar -xzf /tmp/openmv.tar.gz --directory /tmp/
        sh /tmp/openmv-ide/setup.sh
        rm /tmp/openmv.tar.gz
        rm -rf /tmp/openmv-ide/
        ;;
esac

#setup GIT
case $git in
    Y*|y*)
        apt install git wget gnupg-utils fdisk -y
        gpg --output /tmp/secrets.tar.gz --decrypt $secloc
        tar -xzf /tmp/secrets.tar.gz /tmp/
        gpg --import  /tmp/secrets/public.key
        gpg --import  /tmp/secrets/private.key
        mkdir -p "/home/$user/.ssh/"
        cp ./secrets/ssh-robosoccer "/home/$user/.ssh/ssh-robosoccer"
        cp ./secrets/ssh-robosoccer.pub "/home/$user/.ssh/ssh-robosoccer.pub"
        sudo -u $user "git config --global user.signingkey 08242B7544C76B9E9B4EFB91C6C9DC589850AB7D"
        wget https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/.gitmessage.txt -O /home/$user/.gitmessage.txt
        sudo -u $user  "git config --global commit.template ~/.gitmessage.txt"
        ;;
esac

#download git repo
case $gitrep in
    Y*|y*)
        sudo -u $user "git clone git@github.com:mendelcollege-robotics/robotica.git $gitreploc"
        ;;
esac

sl -1 -F -a | lolcat
cat << "EOF"






                ________________
               /                \
               | Setup complete |
               |    see you     |
               |   next time!   |
               \_____    _______/
                    |  /
                    | /
                    |/
            \|/
        -----------
        |         |
        |  ~    0 |
        |         |
        | \_____/ |
        -----------
        __/    \__
       /    \ /   \
      /  |[] |  |  \
     /  /|   |  |\  \
    |  | |   |  | |  |
    |  | |   |  | |  |
    |__| |      | |__|
    {  } ==={}=== {  }
    /||\ |  ||  | /||\
         |  ||  |
         |  ||  |
         |  ||  |
         |  ||  |
     /---   ||   ---\
    /______/  \______\
EOF
sleep 2

cat << "EOF"














































































EOF
fortune -a | cowsay -f tux | lolcat
