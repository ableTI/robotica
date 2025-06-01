#! /bin/bash
cat << "EOF"






                ________________
               /                \
               |   Welkome to   |
               |  the robotics  |
               |  linux setup   |
               |    script!!    |
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
while true; do
    read -p "Please select (1)The automatic setup script, (2)The guided setup script or (3)Exit this script)? [1]/[2]/[3]:  " chpw
    case $chpw in
        1|a*|A*)
            sh -c "$(curl -sSL https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/recoscript.sh)"
            ;;
        2|g*|G*)
            sh -c "$(curl -sSL https://raw.githubusercontent.com/mendelcollege-robotics/robotica/refs/heads/main/setup/selectscript.sh)"
            ;;
        3|e*|E*)
            ;;
        *)
            echo 'Unrecognised input, please try again'
            ;;
    esac

done
