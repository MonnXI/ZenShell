#!/bin/bash
curl -L https://raw.githubusercontent.com/Lichen13/Exodux/main/Attention.txt?token=GHSAT0AAAAAACO4OPVONJFTELCXPGWPZPMAZPDTJYA

read -p "┌[ZenShell] > " commandvar

running=$true

version="1.0.0"

while [ $running == $false ]; do

    if [ $commandvar == "sudo" ]; then
        echo -e "└Your terminal is now admin !"
        read -p "┌[ZenShell] > " commandvar
    elif [ $commandvar == "exit" ]; then
        echo -e "└Exiting..."
        exit
    elif [ $commandvar == "version" ]; then
        echo "└ZenShell is now in version : $version"
        read -p "┌[ZenShell] > " commandvar
    elif [ $commandvar == "clear" ]; then
        clear
        read -p "┌[ZenShell] > " commandvar
    else
        echo -e "\e[1;31m└Error 1: command not found\e[0m"
        read -p "┌[ZenShell] > " commandvar
    fi
done
