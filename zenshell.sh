#!/bin/bash
latestVersion=$(curl -s 'https://raw.githubusercontent.com/MonnXI/ZenShell/main/latestVersion.txt')

running=true

version="1.0.1"

if [ "$latestVersion" != "$version" ]; then
    echo "IMPORTANT --- Your system needs an update !"
fi

read -p "┌[ZenShell] > " commandvar arg1 arg2

while [ "$running" == true ]; do

    if [ "$commandvar" == "exit" ]; then
        echo -n "└Exiting."
        sleep 0.5
        echo -n "."
        sleep 0.5
        echo "."
        sleep 0.5
        exit
    elif [ "$commandvar" == "version" ]; then
        echo "│ZenShell is now in version : $version"
        echo "└The latest version is : $latestVersion"
        read -p "┌[ZenShell] > " commandvar arg1 arg2
    elif [ "$commandvar" == "clear" ]; then
        clear
        read -p "┌[ZenShell] > " commandvar arg1 arg2
    elif [ "$commandvar" == "module" ]; then
        echo -e "\e[1;31m└Error 2: command is none\e[0m"
        if [ "$arg1" == "install" ]; then
            echo "true"
        elif [ "$arg1" == "update" ]; then
            curl -L "$arg2"
        fi
        read -p "┌[ZenShell] > " commandvar arg1 arg2
    elif [ "$commandvar" == "help" ]; then
        echo -e "│Help menu : \n│Command help [no arguments]: show this menu\n│Command exit [no arguments]: exit the terminal\n│Command version [no arguments]: show the actual version and the latest version of ZenShell\n│Command clear [no arguments]: clear the terminal\n└Command module [install/remove/update] [package_url]: manage the modules of ZenShell"
        read -p "┌[ZenShell] > " commandvar arg1 arg2
        #ENTER MODULES HERE
    else
        echo -e "\e[1;31m└Error 1: command not found\e[0m"
        read -p "┌[ZenShell] > " commandvar arg1 arg2
    fi
done
