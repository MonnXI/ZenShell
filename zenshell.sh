#!/bin/bash

latestVersion=$(curl -s 'https://raw.githubusercontent.com/MonnXI/ZenShell/stable/update/latestVersion.txt')
latestBeta=$(curl -s 'https://raw.githubusercontent.com/MonnXI/ZenShell/beta/update/latestVersion.txt')
running=true

declare -A moduleNames
beta=false
version="1.1.1"
goodVersion=true

mKey=0

if [ "$beta" == false ]; then
    if [ "$latestVersion" != "$version" ]; then
        echo "IMPORTANT --- Your stable system needs an update !"
        goodVersion=false
    fi
else
    if [ "$latestBeta" != "$version" ]; then
        echo -e "IMPORTANT --- Your beta system needs an update !"
        goodVersion=false
    fi
fi

read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4

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
        read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
    elif [ "$commandvar" == "clear" ]; then
        clear
        read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
    elif [ "$commandvar" == "module" ]; then
        if [ "$arg1" == "" ]; then
            echo -e "module command:\narg1: install / remove / update\narg2: module_url / module_name"
        elif [ "$arg1" == "install" ]; then
            if [ "$arg2" == "" ]; then
                echo -e "\e[1;31m└Error 3: missing arguments\e[0m"
            elif [ "$arg2" != "" ]; then
                module=$(curl -s "$arg2")
                line_number=60
                module_name=$(curl -s "$arg2" | grep "name=")
                if [ -n "$module_name" ]; then
                    awk -v content="$module" -v line="$line_number" 'NR == line {print content} {print}' zenshell.sh > zenshell.tmp && mv zenshell.tmp zenshell.sh
                    echo -e "└Successfully downloaded : $module_name"
                else
                    echo -e "\e[1;31m└Error 4: this is not a module\e[0m"
                fi
            fi
        fi
        read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
    elif [ "$commandvar" == "help" ]; then
        echo -e "│Help menu : \n│Command help [no arguments]: show this menu\n│Command exit [no arguments]: exit the terminal\n│Command version [no arguments]: show the actual version and the latest version of ZenShell\n│Command clear [no arguments]: clear the terminal\n└Command module [install/remove/update] [module_url(install)/module_name(remove/update)]: manage the modules of ZenShell"
        read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
    elif [ "$commandvar" == "update" ]; then
        if [ "$arg1" == "stable" ]; then
            if [ "$goodVersion" == false ]; then
                if [ "$beta" == false ]; then
                    curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/stable/zenshell.sh"
                    echo "└Successfully updated stable ZenShell"
                    read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
                fi
            elif [ "$beta" == true ]; then
                curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/stable/zenshell.sh"
                echo "└Successfully switched to stable ZenShell. Restart ZenShell to use it"
                read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
            else
                echo "└ZenShell is already to the newest version"
                read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
            fi
        elif [ "$arg1" == "beta" ]; then
            if [ "$goodVersion" == false ]; then
                if [ "$beta" == true]; then
                    curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/beta/zenshell.sh"
                    echo "└Successfully updated your ZenShell beta"
                    read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
                elif [ "$beta" == false ]; then
                    echo "└Your ZenShell stable is not updated. To switch to beta please update to latest stable version then to beta."
                fi
            elif [ "$beta" == false ]; then
                curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/beta/zenshell.sh"
                echo "└Successfully switched to ZenShell beta. Restart ZenShell to use it."
                read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
            else
                echo "└ZenShell is already to the newest version"
                read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
            fi
        else
            if [ "$goodVersion" == false ]; then
                if [ "$beta" == false ]; then
                    curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/stable/zenshell.sh"
                    echo "└Successfully updated stable ZenShell"
                    read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
                else
                    curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/beta/zenshell.sh"
                    echo "└Successfully updated beta ZenShell"
                    read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
                fi
            else
                echo "└ZenShell is already to the newest version"
                read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
            fi
        fi
        #ENTER MODULES HERE
    elif [ "$commandvar" == "" ]; then
        read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
    else
        echo -e "\e[1;31m└Error 1: command not found\e[0m"
        read -p "┌[ZenShell] > " commandvar arg1 arg2 arg3 arg4
    fi
done

# Error list:
# Error 1: command not found
# Error 2: command is none
# Error 3: missing arguments
# Error 4: this is not a module
