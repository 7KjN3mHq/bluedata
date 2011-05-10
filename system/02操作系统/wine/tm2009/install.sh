#!/bin/sh
cp -f wine-tm2009 /usr/bin/
chmod +x /usr/bin/wine-tm2009
cp -f *.desktop /usr/share/applications/
cp -f tm2009.gif /usr/share/icons/
mkdir -p /usr/share/wine/Tencent
cp -f tm2009_single.exe /usr/share/wine/Tencent/
