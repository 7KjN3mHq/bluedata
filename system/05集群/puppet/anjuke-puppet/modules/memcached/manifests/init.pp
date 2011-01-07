class anjuke::memcached
{
    package
    {
        memcached:
        ensure  => installed,
    }
    file
    {
        memcached:
        name    => "/etc/sysconfig/memcached",
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => 644,
        content => template("memcached/memcached.erb"),
        require => Package["memcached"];
    }
    service
    {
        memcached:
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["memcached"],
        subscribe => File["memcached"],
    }
}
