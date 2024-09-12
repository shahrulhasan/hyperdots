#!/usr/bin/env bash
#|---/ /+----------------------------------------+---/ /|#
#|--/ /-| Script to install pkgs from input list |--/ /-|#
#|-/ /--| Matthieu Amet                          |-/ /--|#
#|-/ /--| Prasanth Rangan                        |-/ /--|#
#|/ /---+----------------------------------------+/ /---|#

scrDir=$(dirname "$(realpath "$0")")
source "${scrDir}/../global_fn.sh"
if [ $? -ne 0 ]; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

listPkg="${1:-"${scrDir}/deps.lst"}"

echo -e "\033[0;31mNote: Installing with APT in CLI is at risks, be sure you know what you do before continuing.\033[0m You can install the packages manually and go back to this script if needed."
read -p " :: Press y to continue : " aptwarning
case ${aptwarning} in
    y) ;;
    *) exit ;;
esac

while read -r pkg; do
    pkg="${pkg// /}"
    if [ -z "${pkg}" ]; then
        continue
    fi
    if pkg_installed "${pkg}"; then
        echo -e "\033[0;33m[skip]\033[0m ${pkg} is already installed..."
    elif pkg_available "${pkg}"; then
        echo -e "\033[0;32m[o]\033[0m Installing ${pkg} from official debian repo..."
        sudo apt install -y --force-yes ${pkg} &>/dev/null
    else
        echo "Error: unknown package ${pkg}..."
    fi
done < <(cut -d '#' -f 1 "${listPkg}")
