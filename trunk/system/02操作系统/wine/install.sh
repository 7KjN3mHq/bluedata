#!/bin/sh
#add-apt-repository ppa:ubuntu-wine/ppa
#add-apt-repository ppa:wine-cn/ppa  ## cn mirror
#apt-get update
#apt-get install wine1.3 winetricks
#wget http://www.kegel.com/wine/winetricks -O /usr/bin/winetricks
#chmod +x /usr/bin/winetricks
winetricks msxml3 gdiplus riched20 riched30 ie6 vcrun6 vcrun2005sp1 flash
regedit zh.reg
ln -s /usr/share/fonts/truetype/wqy/wqy-microhei.ttc  ~/.wine/drive_c/windows/Fonts/
