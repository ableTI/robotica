1.Download an debian testing live iso, i recomend the [Live Xfce ISO](https://cdimage.debian.org/cdimage/weekly-live-builds/amd64/iso-hybrid/debian-live-testing-amd64-xfce.iso) for it is the most lightweight of them.

2. Flash it using [Rufus] (https://rufus.ie/nl/). The default settings are mostly fine, but make shute the Persistent partition size is big enough, becouse that is where all you files will be stored. If it asks you to download somthing from the internet the anser is usualy yes..

3. In order to boot the system you will need to turn of the device where you will run it on. After that you will need to go into you system's boot menu. For the laptops at school you will need to enter it with this [manual](https://support.lenovo.com/us/en/solutions/ht104668-how-to-select-boot-device-from-bios-boot-menu-ideapad-thinkpad-thinkstation-thinkcentre-ideacentre). If you want to do it via another device you will need to search for an manual yourself.

4. Run the [setup script](https://github.com/mendelcollege-robotics/robotica/blob/main/setup/setupscr.sh) via *sh -c "$(curl -sSL https://github.com/mendelcollege-robotics/robotica/blob/main/setup/setupscr.sh)"*
