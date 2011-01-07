class anjuke::php
{
	$packlist = [ 	"php",
			"php-devel",
			"php-cli",
			"php-mysql",
			"php-pdo",
			"php-common",
#			"php-pecl-memcache",
			"php-xml",
			"php-bcmath",
#			"php-fpm",
			"php-xcache",
			"php-mbstring",
			"php-gd",
			"php-mcrypt",
		]

        package {
		$packlist:
                ensure => installed,
        }
        file {
        	"php.ini":
        	mode => 644, owner => root, group => root,
        	ensure => present,
        	name    => "/etc/php.ini",
        	content => template("php/php.ini.erb"),
        	require => package["php"];
       }
	class memcache
	{
        	package
        	{
               		"php-pecl-memcache":
	                ensure => installed,
       		        require => Package["php"];
        	}
        	file
        	{
                	"memcache.ini":
                	mode => 644, owner => root, group => root,
                	ensure => present,
                	name    => "/etc/php.d/memcache.ini",
        	        content => template("php/memcache.ini.erb"),
                	require => [Class["anjuke::php"],Package["php-pecl-memcache"]];
        	}
	}
}

