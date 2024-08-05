#!/bin/bash

#######################################################################
# If you never ran ZenShell run this script to install all dependencies and modules to be able to run ZenShell.
#
# Program: ZenShell
# Copyright (c) 2024 MonnTheBoss, Lichen
# 
# Usage:
#   To use this script, run:
#   ./install.sh
#
# This script is governed by the terms of the GNU General Public License v3.0
# The latest version of the license can be found at:
# https://www.gnu.org/licenses/gpl-3.0.html
#######################################################################

echo -e "Checking packages..."

if ! which jq > /dev/null; then
    read -p "jq not found! Install? (Y/n) \c" answer
    if "$answer" = "Y"; then
        sudo apt-get install jq
    elif [ "$answer" == "" ]; then
        sudo apt-get install jq
    fi
else
    echo -e "jq is present on the system!"
fi
if ! which curl > /dev/null; then
    read -p "cURL not found! Install? (Y/n) \c" answer
    if "$answer" = "Y"; then
        sudo apt-get install curl
    elif [ "$answer" == "" ]; then
        sudo apt-get install curl
    fi
else
    echo -e "cURL is present on the system!"
fi
if ! which nmcli > /dev/null; then
    read -p "nmcli not found! Install? (Y/n) \c" answer
    if "$answer" = "Y"; then
        sudo apt-get install nmcli
    elif [ "$answer" == "" ]; then
        sudo apt-get install nmcli
    fi
else
    echo -e "nmcli is present on the system!"
fi

read -p "Which version do you want to install [beta/stable]" release

if [ "$release" == "stable" ]; then
    curl -O https://raw.githubusercontent.com/MonnXI/ZenShell/stable/zenshell.sh
    make zenshell
    mv zenshell /usr/local/bin
    rm zenshell.sh
    exit
elif [ "$release" == "beta" ]; then
    curl -O https://raw.githubusercontent.com/MonnXI/ZenShell/beta/zenshell.sh
    make zenshell
    mv zenshell /usr/local/bin
    rm zenshell.sh
    exit
else
    echo "Please enter a correct answer."
    read -p "Which version do you want to install [beta/stable]" release
