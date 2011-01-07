class anjuke::nginx
{
        package {
                "nginx-stable":
                ensure => installed,
        }

        file {
                "nginx.conf":
                mode => 644, owner => root, group => root,
                ensure => present,
                name    => "/etc/nginx/nginx.conf",
                content => template("nginx/nginx.conf.erb"),
                require => package["nginx-stable"];
       }

        service {
                "nginx":
                ensure => running,
                enable => true,
                hasrestart => true,
                hasstatus => true,
                require => Package["nginx-stable"],
		subscribe => File["nginx.conf"],
        }

}
