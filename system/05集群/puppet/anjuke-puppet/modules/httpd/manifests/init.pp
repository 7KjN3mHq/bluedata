class anjuke::httpd
{
    $packagelist = ["httpd"]
    group {"apache": ensure => present, require => Package["httpd"]}
    user  {"apache": ensure => present, home => "/var/www",
            managehome => false, membership => minimum, groups => [],
            shell => "/sbin/nologin", require => Package["httpd"],
        }

    package {
        $packagelist:
        ensure => present,
    }

    exec { "reload-apache2":
        command => "/etc/init.d/httpd reload",
        onlyif => "/usr/sbin/apachectl -t",
        require => Service["httpd"],
        refreshonly => true,
    }

    file {
        httpd_conf:
        name => '/etc/httpd/conf/httpd.conf',
        owner => root,
        group => root,
        mode => 644,
        content => template("httpd/httpd_conf.erb"),
        require => package["httpd"];

	welcome:
	name => "/etc/httpd/conf.d/welcome.conf",
	ensure => absent,
	require => package["httpd"];

  #ensure that only managed apache file are present - commented out by default
       "/etc/httpd/conf.d":
       ensure  => directory, checksum => mtime,
       #recurse => true, purge => true, force => true,
       mode    => 0644, owner => root, group => root,
       notify  => Exec["reload-apache2"],
       ignore  => [".svn",".ignore"],
       require => Package["httpd"]
    }

    service {
        "httpd":
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["httpd"],
        subscribe => File["httpd_conf"],
   }

    define vhost ( $admin = "webmaster", $aliases = '', $docroot, $ensure = 'present', $domain = "")
    {
        file { "/etc/httpd/conf.d/$name.conf":
            mode => "644",
            ensure => $ensure,
            require => Package["httpd"],
            notify => Exec["reload-apache2"],
            content => template("httpd/vhost.conf.erb"),
        }
    }
}
