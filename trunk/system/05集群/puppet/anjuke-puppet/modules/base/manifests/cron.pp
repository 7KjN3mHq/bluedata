class anjuke::cron
{ 
	package
	{ "crontabs":
	  ensure => installed,
	}
	service
	{
	"crond":
	ensure => running,
	enable => true,
	require => Package["crontabs"];
	}
        cron
        { ntpdate:
          command => "/usr/sbin/ntpdate 10.10.6.130",
            user => root,
            hour => 0,
            minute => 0,
	  require => Package["crontabs"];
        }
}
