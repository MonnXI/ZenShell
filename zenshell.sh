#!/bin/bash

#######################################################################
# Program: ZenShell
# Copyright (c) 2024 MonnTheBoss, Lichen
# 
# Usage:
#   To use this script, run:
#   ./zenshell.sh
#
# This script is governed by the terms of the GNU General Public License v3.0
# The latest version of the license can be found at:
# https://www.gnu.org/licenses/gpl-3.0.html
#
# ZenShell's website can be found at http://76.70.62.206:8080
#######################################################################


latestVersion=$(curl -s 'https://raw.githubusercontent.com/MonnXI/ZenShell/stable/update/latestVersion.txt')
latestBeta=$(curl -s 'https://raw.githubusercontent.com/MonnXI/ZenShell/beta/update/latestVersion.txt')
running=true
declare -A modules
modules=( ["module"]="https://raw.githubusercontent.com/MonnXI/ZenShell/stable/exopod/packages/module" ["print"]="https://raw.githubusercontent.com/MonnXI/ZenShell/stable/exopod/packages/print")
beta=true
version="1.2.12 (beta)"
goodVersion=true

#echo "${modules[module]}" IT WORKS !!!

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

read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4

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
        read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
    elif [ "$commandvar" == "clear" ]; then
        clear
        read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
        read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
    elif [ "$commandvar" == "exopod" ]; then
        read -p "│[Exopod] ➜ " exoMain exo1 exo2 exo3
        if [ "$exoMain" == "" ]; then
            echo -e "\033[1;31m└[x] Error 3: missing arguments\033[0m"
        elif [ "$exoMain" == "install" ]; then
            if [ "$exo1" == "" ]; then
                echo -e "\033[1;31m└[x] Error 3: missing arguments\033[0m"
            else
                if [[ -v modules["$exo1"] ]]; then
                    downloadModule=$(curl -s "${modules["$exo1"]}")
                    #Change the line in case of update
                    line_number=268
                    awk -v content="$downloadModule" -v line="$line_number" 'NR == line {print content} {print}' zenshell.sh > zenshell.tmp && mv zenshell.tmp zenshell.sh
                    chmod u+x zenshell.sh
                    echo -e "└Successfully downloaded : $exo1"
                else
                    echo -e "\033[1;31m└[x] Error 9: could not install the package, check your internet connection\033[0m"
                fi
            fi
        elif [ "$exoMain" == "info" ]; then
            echo -e "│\n│Exopod command:\n│\n│install : to install an exopod package\n│version : to get the version of exopod\n│remove : to uninstall an exopod package\n│info : show this message\n└update : to update an exopod package"
        elif [ "$exoMain" == "remove" ]; then
            if [ "$exo1" == "" ]; then
                echo -e "\033[1;31m└[x] Error 3: missing arguments\033[0m"
            else
                if [[ -v modules["$exo1"] ]]; then
                    moduleStartLine=$(grep -n "elif \[ \"\$commandvar\" == \"$exo1\" \]; then" zenshell.sh | cut -d: -f1)
                    moduleEndLine=$(grep -n "elif \[ \"\$commandvar\" == \"[a-zA-Z0-9]*\" \]; then" zenshell.sh | grep -A1 -m1 "$exo1" | tail -n1 | cut -d: -f1)
                    if [ -n "$moduleStartLine" ] && [ -n "$moduleEndLine" ]; then
                        moduleEndLine=$((moduleEndLine - 1))
                        sed -i "$moduleStartLine,${moduleEndLine}d" zenshell.sh
                        echo "└Module $exo1 removed successfully."
                    else
                        echo "\033[1;31m└[x] Error 10: could not find module's borders\033[0m"
                    fi
                fi
            fi
        elif [ "$exoMain" == "update" ]; then
            if [[ -v modules["$exo1"] ]]; then
                    moduleStartLine=$(grep -n "elif \[ \"\$commandvar\" == \"$exo1\" \]; then" zenshell.sh | cut -d: -f1)
                    moduleEndLine=$(grep -n "elif \[ \"\$commandvar\" == \"[a-zA-Z0-9]*\" \]; then" zenshell.sh | grep -A1 -m1 "$exo1" | tail -n1 | cut -d: -f1)
                    if [ -n "$moduleStartLine" ] && [ -n "$moduleEndLine" ]; then
                        moduleEndLine=$((moduleEndLine - 1))
                        sed -i "$moduleStartLine,${moduleEndLine}d" zenshell.sh
                    fi
                    downloadModule=$(curl -s "${modules["$exo1"]}")
                    awk -v content="$downloadModule" -v line="$line_number" 'NR == line {print content} {print}' zenshell.sh > zenshell.tmp && mv zenshell.tmp zenshell.sh
                    chmod u+x zenshell.sh
                    echo -e "└Successfully updated : $exo1"
            fi
        else
            echo -e "\033[1;31m└[x]Error 1: command not found\033[0m"
        fi
        read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
    elif [ "$commandvar" == "help" ]; then
        echo -e "│Help menu : \n│Command help [n arguments]: show this menu\n│Command exit [no arguments]: exit the terminal\n│Command version [no arguments]: show the actual version and the latest version of ZenShell\n│Command clear [no arguments]: clear the terminal\n│Command module [install/remove/update] [module_url(install)/module_name(remove/update)]: manage the modules of ZenShell\n│Command wifi [list/connect] [ssid] [password]: to list wifi connections available or connect to a wifi with wpa2 or wpa3 security\n└Command update [beta/stable/info]: to switch from stable to beta just update or know the update infos"
        read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
    elif [ "$commandvar" == "update" ]; then
        echo -e "│--- Update command ---"
        echo -e "│"
        echo -e "│ beta : to update to beta version"
        echo -e "│ stable : to update to stable version"
        echo -e "│ info : to get the information about the update"
        echo -e "│ let empty to just update your zenshell"
        echo -e "│"
        read -p "│[Update] ➜ " arg1 arg2 
        if [ "$arg1" == "stable" ]; then
            if [ "$goodVersion" == false ]; then
                if [ "$beta" == false ]; then
                    curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/stable/zenshell.sh"
                    echo "└Successfully updated stable ZenShell"
                    read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
                fi
            elif [ "$beta" == true ]; then
                curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/stable/zenshell.sh"
                echo "└Successfully switched to stable ZenShell. Restart ZenShell to use it"
                read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
            else
                echo "└ZenShell is already to the newest version"
                read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
            fi
        elif [ "$arg1" == "beta" ]; then
            if [ "$goodVersion" == false ]; then
                if [ "$beta" == true]; then
                    curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/beta/zenshell.sh"
                    echo "└Successfully updated your ZenShell beta"
                    read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
                elif [ "$beta" == false ]; then
                    echo "└Your ZenShell stable is not updated. To switch to beta please update to latest stable version then to beta."
                fi
            elif [ "$beta" == false ]; then
                curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/beta/zenshell.sh"
                echo "└Successfully switched to ZenShell beta. Restart ZenShell to use it."
                read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
            else
                echo "└ZenShell is already to the newest version"
                read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
            fi
        elif [ "$arg1" == "" ]; then
            if [ "$goodVersion" == false ]; then
                if [ "$beta" == false ]; then
                    curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/stable/zenshell.sh"
                    echo "└Successfully updated stable ZenShell"
                    read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
                else
                    curl -O "https://raw.githubusercontent.com/MonnXI/ZenShell/beta/zenshell.sh"
                    echo "└Successfully updated beta ZenShell"
                    read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
                fi
            else
                echo "└ZenShell is already to the newest version"
                read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
            fi
        elif [ "$arg1" == "info" ]; then
            if [ "$beta" == false ]; then
                curl -L "https://raw.githubusercontent.com/MonnXI/ZenShell/stable/update/updateInfo.txt"
                read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
            elif [ "$beta" == true ];then
                curl -L "https://raw.githubusercontent.com/MonnXI/ZenShell/beta/update/updateInfo.txt"
                read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
            fi
        fi
    elif [ "$commandvar" == "osinf" ]; then
        version=$(grep -E '^VERSION=' /etc/os-release | awk -F'=' '{print $2}' | sed 's/"//g')
        osName=$(grep -E '^NAME=' /etc/os-release | awk -F'=' '{print $2}' | sed 's/"//g')
        echo -e "│➜ Os name is $osName"
        echo -e "└➜ Version is $version"
        read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
    elif [ "$commandvar" == "wifi" ]; then
        if [ "$arg1" == "" ]; then
            echo -e "│ WiFi command:"
            echo -e "│ "
            echo -e "│ list : show available wifi networks"
            echo -e "│ connect SSID passwd : connect to a wifi network using passwd and ssid\n│"
            read -p "│[Wifi] ➜ " warg1 warg2 warg3
            if [ "$warg1" == "list" ]; then
                nmcli dev wifi list
            elif [ "$warg1" == "connect" ]; then
                if [ "$warg2" == "" ]; then
                    echo -e "\033[1;31m└[x] Error 3: missing arguments\033[0m" 
                    read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
                elif [ "$warg2" != "" ]; then
                    if [ "$warg3" != "" ]; then
                        sudo nmcli dev wifi connect "$warg2" password "$warg3"
                        beforeTime=$(date +%s)
                        while true; do
                            startTime=$(date +%s)
                            runningTime=$((startTime - beforeTime))
                            echo -e "\033[1A\033[K│ [/] connecting"
                            sleep 0.3
                            echo -e "\033[1A\033[K│ [|] connecting"
                            sleep 0.3
                            echo -e "\033[1A\033[K│ [\\] connecting"
                            sleep 0.3
                            if [ $runningTime -ge 4 ]; then
                                break
                            fi
                        done
                        connectionCheck=$(nmcli dev wifi list | grep "$warg2")
                        if [[ $connectionCheck =~ * ]]; then
                            echo -e "\033[1A\033[K└ Connected :p"
                        else
                            echo -e "\033[1;31m└[x] Error 6: failed to connect to internet\033[0m"
                        fi
                    else
                        echo -e "\033[1;31m└[x] Error 3: missing arguments\033[0m" 
                    fi
                fi
            fi
            read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
        elif [ "$arg1" == "list" ]; then
            nmcli dev wifi list
            read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
        elif [ "$arg1" == "connect" ]; then
            if [ "$arg2" == "" ]; then
                echo -e "\033[1;31m└[x] Error 3: missing arguments\033[0m" 
                read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
            elif [ "$arg2" != "" ]; then
                sudo nmcli dev wifi connect "$arg2" password "$arg3"
                beforeTime=$(date +%s)
                while true; do
                    startTime=$(date +%s)
                    runningTime=$((startTime - beforeTime))
                    echo -e "\033[1A\033[K│ [/] connecting"
                    sleep 0.3
                    echo -e "\033[1A\033[K│ [|] connecting"
                    sleep 0.3
                    echo -e "\033[1A\033[K│ [\\] connecting"
                    sleep 0.3
                    if [ $runningTime -ge 4 ]; then
                        break
                    fi
                done
                connectionCheck=$(nmcli dev wifi list | grep "$arg2")
                if [[ $connectionCheck =~ * ]]; then
                    echo -e "\033[1A\033[K└ Connected :p"
                else
                    echo -e "\033[1;31m└[x] Error 6: failed to connect to internet\033[0m"
                fi
                read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
            fi
        read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
        fi
    elif [ "$commandvar" == "date" ]; then
        echo "└ $(date)"
        read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
        #ENTER MODULES HERE
    elif [ "$commandvar" == "" ]; then
        read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
    else
        echo -e "\033[1;31m└[x] Error 1: command not found\033[0m"
        read -p "┌[ZenShell] ➜ " commandvar arg1 arg2 arg3 arg4
    fi
done

# Error list:
# Error 1: command not found
# Error 2: command is none
# Error 3: missing arguments
# Error 4: this is not a module
# Error 5: this argument does not exist
# Error 6: failed to connect to internet
# Error 7: cannot reach url
# Error 8: no internet connection
# Error 9: could not install the package, check your internet connection
# Error 10: could not find module's borders
