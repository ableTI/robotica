# Downloading
Download an debian testing live iso, i recomend the [Live Xfce ISO](https://cdimage.debian.org/cdimage/weekly-live-builds/amd64/iso-hybrid/debian-live-testing-amd64-xfce.iso) for it is the most lightweight of them.

# Flashing
Flash it using [Rufus] (https://rufus.ie/nl/). The default settings are mostly fine, but make shute the Persistent partition size is big enough, becouse that is where all you files will be stored. If it asks you to download somthing from the internet the anser is usualy yes..

# Booting
In order to boot the system you will need to turn of the device where you will run it on. After that you will need to go into you system's boot menu. For the laptops at school you will need to enter it with this [manual](https://support.lenovo.com/us/en/solutions/ht104668-how-to-select-boot-device-from-bios-boot-menu-ideapad-thinkpad-thinkstation-thinkcentre-ideacentre). If you want to do it via another device you will need to search for an manual yourself.

# Change password
In the terminal type *passwd* and follow the instructions

# Setup git
In order to use git you will need to configure an [GPG](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key) and an [SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) key. [DONT FORGET](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key) && [How to use git](https://education.github.com/git-cheat-sheet-education.pdf).
(SSH is blocked on the mendelnetwork so setup https auth via *gh auth*)

Configure the [commit template](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration) *wget https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/.gitmessage.txt -O ~/.gitmessage.txt && git config --global commit.template ~/.gitmessage.txt*

clone repo using *git clone repolink*

# Setup arduino 1.x
open a terminal and enter, 
*sudo apt install arduino*

# Setup arduino 2.x
1. Download the arduino install linux zip file on the [arduino website](https://www.arduino.cc/en/software/).

2. Extract it.

3. Place it into the /usr/share folder with the command *sudo mv /path/to/arduino-ide_2.X.X_Linux_64bit /usr/sharearduino-ide_2.X.X_Linux_64bit*

4. Create an .desktop file in /usr/share/applications/ called arduino2.desktop with [this](https://github.com/mendelcollege-robotics/robotica/blob/main/setup/arduino2.desktop) content by entering *sudo wget https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/arduino2.desktop -O /usr/share/applications/arduino2.desktop*

5. Edit the file to your version with *sudo nano /usr/share/applications/arduino2.desktop*. To exit see help commands below (^ means ctrl).

# [Setup teensyduino](https://www.pjrc.com/teensy/td_download.html)

# [Setup arduino for Seeed Xiao](https://wiki.seeedstudio.com/Seeed_Arduino_Boards/)

# Setup KiCAD
open a terminal and enter, 
*sudo apt intall kicad*

# Setup OpenMV
Go to the [openMV website](https://openmv.io/pages/download) and download the ubuntu tar.gz and extract it. Run /path/to/openmv-ide/setup.sh

# Fussion 360
I am not sure if it works but there is [an way to make it work on linux](https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux) via [wine](https://www.winehq.org/).

# [Zephyr](https://docs.zephyrproject.org/latest/develop/getting_started/index.html)

# Usefull packages
in your terminal run: 
*sudo apt update && sudo apt install --no-install-recommends git cmake ninja-build gperf
  ccache dfu-util device-tree-compiler wget \
  python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file \
  make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1 \
  python3-venv putty supertuxkart thefuck sl inkscape blender \
  freecad kate vlc krita gnupg-utils micro nano cheese \
  kleopatra qbittorrent wireguard nmap usb-utils gparted*
