class anjuke::mysql
{
    $packagelist= ["mysql-server"]
    package
    { $packagelist:
        ensure => installed,
    }

    file
    { "my.cnf":
        name  => "/etc/my.cnf",
        owner => root,
        group => root,
        mode  => 600,
        ensure => present,
        content => template("mysql/my.cnf.erb"),
        require => package["mysql-server"];
    }

    service
    { "mysqld":
        ensure => running,
        enable => true,
        require => package["mysql-server"];
    }
}
