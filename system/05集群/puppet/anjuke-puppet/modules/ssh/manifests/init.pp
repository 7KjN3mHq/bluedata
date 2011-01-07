class anjuke::ssh
{
	$port = '22'
	$usedns = 'no'
        package {
                "openssh-server":
                ensure => installed,
        }
        file {
                "sshd_config":
                mode => 600, owner => root, group => root,
                ensure => present,
                name    => "/etc/ssh/sshd_config",
                content => template("ssh/sshd_config.erb"),
                require => package["openssh-server"];
       }

        service {
                "sshd":
                ensure => running,
                enable => true,
                hasrestart => true,
                hasstatus => true,
                require => Package["openssh-server"],
		subscribe => File["sshd_config"],
        }

}
