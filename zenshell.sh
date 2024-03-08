#!/bin/bash
latestVersion=$(curl -s 'https://raw.githubusercontent.com/MonnXI/ZenShell/main/latestVersion.txt')

running=true

version="1.0.1"

if [ "$latestVersion" != "$version" ]; then
    echo "IMPORTANT --- Your system needs an update !"
fi

read -p "┌[ZenShell] > " commandvar arg1

while [ "$running" == true ]; do

    if [ "$commandvar" == "sudo" ]; then
        echo -e "└Your terminal is now admin !"
        read -p "┌[ZenShell] > " commandvar
    elif [ "$commandvar" == "exit" ]; then
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
        read -p "┌[ZenShell] > " commandvar arg1
    elif [ "$commandvar" == "clear" ]; then
        clear
        read -p "┌[ZenShell] > " commandvar arg1
    elif [ "$commandvar" == "module" ]; then
        echo -e "\e[1;31m└Error 2: command is none\e[0m"
        if [ "$arg1" == "install" ]; then
            echo "true"
        fi
        read -p "┌[ZenShell] > " commandvar arg1
    else
        echo -e "\e[1;31m└Error 1: command not found\e[0m"
        read -p "┌[ZenShell] > " commandvar arg1
    fi
done
