class anjuke::puppet
{
    $server = "puppet10-001.i.ajkdns.com"

    package
    { puppet:
      ensure => present,
    }

    file
    { "puppet.conf":
        name => "/etc/puppet/puppet.conf",
        ensure => present,
        owner => root,
        group => root,
        mode => 644,
        content => template("puppet/puppet.conf.erb"),
        require => Package["puppet"];

     "namespaceauth.conf":
        name => "/etc/puppet/namespaceauth.conf",
        ensure => present,
        owner => root,
        group => root,
        mode => 644,
        content => template("puppet/namespaceauth.conf.erb"),
        require => Package["puppet"];
    }

   service {
        "puppet":
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => Package["puppet"],
        subscribe => File["puppet.conf"],
  }

}
