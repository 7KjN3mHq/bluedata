import "php.pp"

class anjuke::php-fpm inherits anjuke::php
{
	package
	{
		php-fpm:
		ensure => installed,
	}
	file
	{
		"php-fpm.conf":
                mode => 644, owner => root, group => root,
                ensure => present,
                name    => "/etc/php-fpm.conf",
                content => template("php/php-fpm.conf.erb"),
                require => package["php-fpm"];

	#ensure that only managed apache file are present - commented out by default
       		"/etc/php.d":
       		ensure  => directory, checksum => mtime,
       #recurse => true, purge => true, force => true,
		mode    => 0644, owner => root, group => root,
       		notify  => Exec["reload-php-fpm"],
       		ignore  => [".svn",".ignore"],
       		require => Package["php-fpm"]
	}

	exec { "reload-php-fpm":
        	command => "/etc/init.d/php-fpm reload",
#        	onlyif => "/usr/sbin/apachectl -t",
        	require => Service["php-fpm"],
        	refreshonly => true,
	}

        service {
                "php-fpm":
                ensure => running,
                enable => true,
                hasrestart => true,
                hasstatus => true,
                require => Package["php-fpm"],
                subscribe => File["php-fpm.conf"],
        }

}
