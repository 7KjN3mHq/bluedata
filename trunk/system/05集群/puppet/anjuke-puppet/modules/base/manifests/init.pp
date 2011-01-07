import "resolv.pp"
import "cron.pp"

class anjuke::base {
	include anjuke::resolv
	include anjuke::cron
        $packagelist = [
		"rmt",
		"dump",
		"rsh",
		"talk",
		"bc",
		"eject",
		"isdn4k-utils",
		"firstboot-tui",
		"system-config-network-tui",
		"kudzu",
		"bluez-utils",
		"usbutils",
		"dhclient","cvs",
		"lftp","yum-updatesd","anacron","dnsmasq","finger"]
        $serlist = [
		"kudzu","portmap","nfs",
		"yum-updatesd","rpcgssd",
		"rpcidmapd","cups","nfslock",
		"netfs","rhnsd","haldaemon",
		 "avahi-daemon"]
        package
        { $packagelist:
                ensure => absent,
        }
        service
        { $serlist:
          ensure => stopped,
          enable => false,
        }

	$userlist = [
		"lp","uucp",
		"halt","news",
		"games","gopher"]
	$grouplist = [
		"lp","uucp",
		"games","news",
		"floppy","audio",]
	user
	{ $userlist:
	  ensure => absent,
	}
	group
	{ $grouplist:
	  ensure => absent,
	}
}
