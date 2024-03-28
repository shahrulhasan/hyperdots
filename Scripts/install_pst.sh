#!/usr/bin/env bash
#|---/ /+--------------------------------------+---/ /|#
#|--/ /-| Script to apply post install configs |--/ /-|#
#|-/ /--| Prasanth Rangan                      |-/ /--|#
#|/ /---+--------------------------------------+/ /---|#

scrDir=$(dirname "$(realpath "$0")")
source "${scrDir}/global_fn.sh"
if [ $? -ne 0 ] ; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi


# themepatcher
echo -e "\033[0;32m[THEMEPATCHER]\033[0m additional themes available..."
awk -F '"' '{print "["NR"]",$2}' "${scrDir}/themepatcher.lst"
prompt_timer 60 "Patch these additional themes? [Y/n]"
thmopt=${promptIn,,}

if [ "${thmopt}" = "y" ] ; then
    echo -e "\033[0;32m[THEMEPATCHER]\033[0m Patching themes..."
    while read -r themeName themeRepo themeCode
    do
        themeName="${themeName//\"/}"
        themeRepo="${themeRepo//\"/}"
        themeCode="${themeCode//\"/}"
        "${scrDir}/themepatcher.sh" "${themeName}" "${themeRepo}" "${themeCode}"
    done < "${scrDir}/themepatcher.lst"
else
    echo -e "\033[0;33m[SKIP]\033[0m additional themes not patched..."
fi


# sddm
read -p "Do you want to change sddm configuration? (y/N): " answer
case $answer in
    [yY])
        echo "Configuring the sddm"
        if pkg_installed sddm
            then

            echo -e "\033[0;32m[DISPLAYMANAGER]\033[0m detected // sddm"
            if [ ! -d /etc/sddm.conf.d ] ; then
                sudo mkdir -p /etc/sddm.conf.d
            fi

            if [ ! -f /etc/sddm.conf.d/kde_settings.t2.bkp ] ; then
                echo -e "\033[0;32m[DISPLAYMANAGER]\033[0m configuring sddm..."
                echo -e "Select sddm theme:\n[1] Candy\n[2] Corners"
                read -p " :: Enter option number : " sddmopt

                case $sddmopt in
                1) sddmtheme="Candy";;
                *) sddmtheme="Corners";;
                esac

                sudo tar -xzf ${CloneDir}/Source/arcs/Sddm_${sddmtheme}.tar.gz -C /usr/share/sddm/themes/
                sudo touch /etc/sddm.conf.d/kde_settings.conf
                sudo cp /etc/sddm.conf.d/kde_settings.conf /etc/sddm.conf.d/kde_settings.t2.bkp
                sudo cp /usr/share/sddm/themes/${sddmtheme}/kde_settings.conf /etc/sddm.conf.d/
            else
                echo -e "\033[0;33m[SKIP]\033[0m sddm is already configured..."
            fi

            if [ ! -f /usr/share/sddm/faces/${USER}.face.icon ] && [ -f ${CloneDir}/Source/misc/${USER}.face.icon ] ; then
                sudo cp ${CloneDir}/Source/misc/${USER}.face.icon /usr/share/sddm/faces/
                echo -e "\033[0;32m[DISPLAYMANAGER]\033[0m avatar set for ${USER}..."
            fi

        else
            echo -e "\033[0;33m[WARNING]\033[0m sddm is not installed..."
        fi
        ;;
    *)
        echo "Skipping sddm configuration"
        ;;
esac


# dolphin
read -p "Do you want to change dolphin configuration? (y/N): " answer
case $answer in
    [yY])
        echo "Configuring the dolphin"
        if pkg_installed dolphin && pkg_installed xdg-utils
            then

            echo -e "\033[0;32m[FILEMANAGER]\033[0m detected // dolphin"
            xdg-mime default org.kde.dolphin.desktop inode/directory
            echo -e "\033[0;32m[FILEMANAGER]\033[0m setting" `xdg-mime query default "inode/directory"` "as default file explorer..."
            kmenuPath="$HOME/.local/share/kio/servicemenus"
            mkdir -p "${kmenuPath}"
            echo -e "[Desktop Entry]\nType=Service\nMimeType=image/png;image/jpeg;image/jpg;image/gif\nActions=Menu-Refresh\nX-KDE-Submenu=Set As Wallpaper..." > "${kmenuPath}/hydewallpaper.desktop"
            echo -e "\n[Desktop Action Menu-Refresh]\nName=.: Refresh List :.\nExec=${HyprdotsDir}/scripts/swwwallkon.sh" >> "${kmenuPath}/hydewallpaper.desktop"
            chmod +x "${kmenuPath}/hydewallpaper.desktop"

        else
            echo -e "\033[0;33m[WARNING]\033[0m dolphin is not installed..."
        fi
        ;;
    *)
        echo "Skipping dolphin configuration"
        ;;
esac


# shell
read -p "Do you want to change shell configuration? (y/N): " answer
case $answer in
    [yY])
        echo "Configuring the shell"
        "${scrDir}/restore_shl.sh"
        ;;
    *)
        echo "Skipping shell configuration"
        ;;
esac


# flatpak
read -p "Do you want to change flatpak configuration? (y/N): " answer
case $answer in
    [yY])
        echo "Configuring the flatpak"
        if ! pkg_installed flatpak
            then

            echo -e "\033[0;32m[FLATPAK]\033[0m flatpak application list..."
            awk -F '#' '$1 != "" {print "["++count"]", $1}' "${scrDir}/.extra/custom_flat.lst"
            prompt_timer 60 "Install these flatpaks? [Y/n]"
            fpkopt=${promptIn,,}

            if [ "${fpkopt}" = "y" ] ; then
                echo -e "\033[0;32m[FLATPAK]\033[0m intalling flatpaks..."
                "${scrDir}/.extra/install_fpk.sh"
            else
                echo -e "\033[0;33m[SKIP]\033[0m intalling flatpaks..."
            fi

        else
            echo -e "\033[0;33m[SKIP]\033[0m flatpak is already installed..."
        fi
        ;;
    *)
        echo "Skipping flatpak configuration"
        ;;
esac

