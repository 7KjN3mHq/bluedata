#!/bin/sh
#wine rtxclient2010formal.exe
#mv "/home/$USER/.wine/drive_c/Program Files/Tencent" /usr/share/wine/Tencent
cp -f wine-rtx2010 /usr/bin/
chmod +x /usr/bin/wine-rtx2010
cp -f *.desktop /usr/share/applications/
cp -f rtx.gif /usr/share/icons/
