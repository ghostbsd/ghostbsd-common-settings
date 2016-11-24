#!/bin/sh

. /root/functions.sh

while
i="1"
do

dialog --title "GhostBSD Configuration Menu" --menu "Please select from the following options:" 20 55 15 xorg "Start graphical install (Auto-Detect Video) " vesa "Start graphical install (VESA)" scfb "Start graphical install (SCFB)" intel "Start graphical install (Legacy Intel)" amd "Start graphical install (Radeon)" utility "System Utilities" reboot "Reboot the system" 2>/tmp/answer

ANS="`cat /tmp/answer`"

case $ANS in
    xorg) echo "Starting graphical Installer (AutoDetect).. Please wait.."
      start_xorg ;;
    vesa) echo "Starting graphical Installer (VESA).. Please wait.."
      cp /root/cardDetect/XF86Config.compat /etc/X11/xorg.conf
      startx 2>/tmp/Xerrors ;;
    scfb) echo "Starting graphical installer (SCFB).. Please wait.."
      cp /root/cardDetect/XF86Config.scfb /etc/X11/xorg.conf
      startx 2>/tmp/Xerrors ;;
    intel) echo "Starting graphical installer (Legacy Intel).. Please wait.."
      cp /root/cardDetect/XF86Config.intel /etc/X11/xorg.conf
      startx 2>/tmp/Xerrors ;;
    amd) echo "Starting graphical installer (Radeon).. Please wait.."
      kldload radeonkms
      startx 2>/tmp/Xerrors ;;
    utility) /root/sysutil.sh
      clear ;;
    reboot)  reboot -q ;;
    *) ;;
esac

done
