#!/bin/bash

# make sure that if any error is thrown in these scripts to terminate the program
set -e;

handle_exit_code() {
  ERROR_CODE="$?";
  printf -- 'An error occured. Removing MultiMC ZIP\n';
  rm MultiMc.tar.gz
  printf -- "DONE.\nExiting with error code %s.\n" ERROR_CODE;
  exit ${ERROR_CODE};
}
trap "handle_exit_code" EXIT;

printf -- "Installing qt5 qt5-qtbase, required for MultiMC\n"
sudo dnf install qt5-qtbase -y

printf -- "Downloading MultiMC...\n"
wget https://files.multimc.org/downloads/mmc-stable-lin64.tar.gz -O /tmp/MultiMC.tar.gz

printf -- "Downloading MultiMC Icon...\n"
wget https://avatars2.githubusercontent.com/u/5411890 -O ~/.local/MultiMC/MultiMC.png

printf -- "Unzipping MultiMC\n"
sudo tar -xf /tmp/MultiMC.tar.gz -C ~/.local/MultiMC/ --strip-components=1

printf -- "Making MultiMC executable\n"
chmod +x ~/.local/MultiMC/MultiMC

printf -- "Removing downloaded ZIP\n"
rm ~/.local/MultiMC/MultiMC.tar.gz

printf -- "Making .desktop file for MultiMC (KDE) \n"
mkdir ~/.local/share/applications

echo "[Desktop Entry]
Comment=
Exec=~/.local/MultiMC/MultiMC
GenericName=Manage Minecraft instances with ease
Icon=~/.local/MultiMC/MultiMC.png
Name=MultiMC
NoDisplay=false
Path[$0]=
StartupNotify=true
Terminal=0
TerminalOptions=
Type=Application
X-KDE-SubstituteUID=false
X-KDE-Username=
" >> ~/.local/share/applications/MultiMC.desktop

printf -- "Downloading JDK 17...\n"
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
sudo rpm -Uvh jdk-17_linux-x64_bin.rpm

printf -- "Finished.\n"
