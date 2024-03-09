#!/bin/bash
latestVersion=$(curl -s 'https://raw.githubusercontent.com/MonnXI/ZenShell/main/update/latestVersion.txt')

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
        if [ "$arg1" == "" ]; then
            echo -e "module command:\narg1: install / remove / update\narg2: module_url / module_name"
        elif [ "$arg1" == "install" ]; then
            if [ "$arg2" == "" ]; then
                echo -e "\e[1;31m└Error 3: missing arguments\e[0m"
            elif [ "$arg2" != "" ]; then
                module_url=$(curl -s "$arg2")
                echo -e "$module_url"
            fi
        elif [ "$arg1" == "update" ]; then
            curl -L "$arg2"
        fi
        read -p "┌[ZenShell] > " commandvar arg1 arg2
    elif [ "$commandvar" == "help" ]; then
        echo -e "│Help menu : \n│Command help [no arguments]: show this menu\n│Command exit [no arguments]: exit the terminal\n│Command version [no arguments]: show the actual version and the latest version of ZenShell\n│Command clear [no arguments]: clear the terminal\n└Command module [install/remove/update] [module_url(install)/module_name(remove/update)]: manage the modules of ZenShell"
        read -p "┌[ZenShell] > " commandvar arg1 arg2
        #ENTER MODULES HERE
    elif [ "$commandvar" == "" ]; then
        read -p "┌[ZenShell] > " commandvar arg1 arg2
    else
        echo -e "\e[1;31m└Error 1: command not found\e[0m"
        read -p "┌[ZenShell] > " commandvar arg1 arg2
    fi
done

# Error list:
# Error 1: command not found
# Error 2: command is none
# Error 3: Missing arguments
