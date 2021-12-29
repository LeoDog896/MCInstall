sudo dnf install qt5-qtbase -y
wget https://files.multimc.org/downloads/mmc-stable-lin64.tar.gz -O MultiMc.tar.gz
wget https://avatars2.githubusercontent.com/u/5411890 -O MultiMC.png
sudo tar -xf MultiMc.tar.gz --strip-components=1
chmod +x ./MultiMC
rm MultiMc.tar.gz
mkdir ~/.local/share/applications
echo "[Desktop Entry]
Comment=
Exec=$0/MultiMC
GenericName=Manage Minecraft instances with ease
Icon=$0/MultiMC.png
Name=MultiMC
NoDisplay=false
Path[$e]=
StartupNotify=true
Terminal=0
TerminalOptions=
Type=Application
X-KDE-SubstituteUID=false
X-KDE-Username=
" >> ~/.local/share/applications/MultiMC.desktop
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
sudo rpm -Uvh jdk-17_linux-x64_bin.rpm
