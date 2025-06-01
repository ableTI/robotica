#! /bin/bash
echo 'Welkom to the robosoccer automatic installment script!'
user=user
pass=2235
#
#check internet connection
wget -q --spider https://github.com
if [ $? -eq 0 ]; then
    echo 'Internet connection found'
else
    echo 'Error, either your device is off-line or https://github.com is off-line.'
    exit
fi

try=0
npw1 = $pass
while true; do
    read -p "Would you like to change the default pasword for $user? [Y]es or [N]o:  " chpw
    case $chpw in
        y*|Y*)
            stty -echo
            printf "Password: "
            read npw1
            stty echo
            printf "\n"
            stty -echo
            printf "Please repeat: "
            read npw2
            stty echo
            printf "\n"
            if [ $npw1 = $npw2 ]; then
                if [ $try = 1 ]; then
                    echo "The password will change at the end of the script"
                    break
                fi
                echo "Passwords didn't match, please try again, or stop atempting."
                try=$((try+1))
            else
                echo "Passwords did not match, please try again, or stop atempting."
            fi
            ;;
        n*|N*)
            break
            ;;
        *)
            echo 'Unrecognised input, please try again'
            ;;
    esac

done
while true;
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
            echo "In case you wish to exit to search the file use Ctrl-C"
            ;;
         *)
            echo "Did not recognize input please retry"
            ;;
    esac
done


echo $pass | sudo -S -k apt install cowsay sl lolcat fortune xscreensaver xscreensaver-data xscreensaver-data-extra xscreensaver-gl xscreensaver-gl-extra xscreensaver-screensaver-bsod xscreensaver-screensaver-dizzy xscreensaver-screensaver-webcollage supertuxkart usbutils arduino usbutils unzip wget git gnupg-utils fdisk -y

#openMV
echo $pass | sudo -S -k wget https://github.com/openmv/openmv-ide/releases/download/development/openmv-ide-linux-x86_64-4.6.1.tar.gz -O /tmp/openmv.tar.gz
echo $pass | sudo -S -k tar -xzf /tmp/openmv.tar.gz --directory /tmp/
echo $pass | sudo -S -k sh /tmp/openmv-ide/setup.sh
echo $pass | sudo -S -k rm /tmp/openmv.tar.gz
echo $pass | sudo -S -k rm -rf /tmp/openmv-ide/

#arduino 2.x
echo $pass | sudo -S -k wget https://downloads.arduino.cc/arduino-ide/nightly/arduino-ide_nightly-20250529_Linux_64bit.zip -O /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip
echo $pass | sudo -S -k unzip /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip -d /usr/share/arduino-ide_nightly-20250529_Linux_64bit
echo $pass | sudo -S -k rm /usr/share/arduino-ide_nightly-20250529_Linux_64bit.zip
echo $pass | sudo -S -k wget https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/arduino2.desktop -O /usr/share/applications/arduino2.desktop

#setup GIT/the repo
echo $pass | sudo -S -k gpg --output /tmp/secrets.tar.gz --decrypt $secloc
echo $pass | sudo -S -k tar -xzf /tmp/secrets.tar.gz /tmp/
gpg --import  /tmp/secrets/public.key
gpg --import  /tmp/secrets/private.key
echo $pass | sudo -S -k mkdir -p "/home/$user/.ssh/"
echo $pass | sudo -S -k cp ./secrets/ssh-robosoccer "/home/$user/.ssh/ssh-robosoccer"
echo $pass | sudo -S -k cp ./secrets/ssh-robosoccer.pub "/home/$user/.ssh/ssh-robosoccer.pub"
sudo -u $user "git config --global user.signingkey 08242B7544C76B9E9B4EFB91C6C9DC589850AB7D"
echo $pass | sudo -S -k wget https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/.gitmessage.txt -O /home/$user/.gitmessage.txt
sudo -u $user  "git config --global commit.template ~/.gitmessage.txt"

#setup xscreensaver
echo $pass | sudo -S -k wget https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/xscreensaver.desktop -O /etc/xdg/autostart/xscreensaver.desktop
echo $pass | sudo -S -k apt remove gnome-screensaver
echo $pass | sudo -S -k wget https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/.xscreensaver -O "/home/$user/.xscreensaver"

#setup password
case $chpw in
    y*|Y*)
        echo $pass | sudo -S -k chpasswd <<<"$user:$npw1"
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

