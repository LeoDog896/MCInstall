#!/bin/bash

# make sure that if any error is thrown in these scripts to terminate the program
set -e;

handle_exit_code() {
  ERROR_CODE="$?";
  printf -- 'Cleaning up...';
  rm /tmp/MultiMC.tar.gz
  printf -- "DONE.\nExiting with error code %s.\n" ERROR_CODE;
  exit ${ERROR_CODE};
}
trap "handle_exit_code" EXIT;

if type dnf &> /dev/null
then
  printf -- "Installing qt5-qtbase, required for MultiMC on this OS\n"
  sudo dnf install qt5-qtbase -y
elif type apt &> /dev/null
then
  printf -- "Installing libqt5core5a libqt5network5 +libqt5gui5, required for MultiMC on this OS\n"
  sudo apt install libqt5core5a libqt5network5 libqt5gui5
elif type zypper &> /dev/null
then
  printf -- "Installing libqt5-qtbase, required for MultiMC on this OS\n"
  sudo zypper install libqt5-qtbase
fi

printf -- "Downloading MultiMC...\n"
mkdir ~/.local/MultiMC
wget https://files.multimc.org/downloads/mmc-stable-lin64.tar.gz -O /tmp/MultiMC.tar.gz

printf -- "Downloading MultiMC Icon...\n"
wget https://avatars2.githubusercontent.com/u/5411890 -O ~/.local/MultiMC/MultiMC.png

printf -- "Unzipping MultiMC\n"
sudo tar -xf /tmp/MultiMC.tar.gz -C ~/.local/MultiMC/ --strip-components=1

printf -- "Making MultiMC executable\n"
chmod +x ~/.local/MultiMC/MultiMC

printf -- "Removing downloaded ZIP\n"
rm /tmp/MultiMC.tar.gz

printf -- "Making .desktop file for MultiMC (KDE) \n"
mkdir -p ~/.local/share/applications

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
