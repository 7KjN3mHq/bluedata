class anjuke::yum
{
    package
    { yum:
        ensure => installed;
    }
    file
    { rhel-server:
        name => '/etc/yum.repos.d/rhel-server.repo',
        ensure => present,
        owner => root,
        group => root,
        mode  => 600,
        require => Package["yum"],
    }
    yumrepo
    { rhel-server:
      descr   => 'base',
      baseurl => 'http://yum.idc10.i.ajkdns.com/rhel5',
      enabled => 1,
      gpgcheck => 0,
      gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release',
      require => File['rhel-server'];
    
      other:
      descr  => 'other',
      baseurl => 'http://yum.idc10.i.ajkdns.com/other',
      enabled => 1,
      gpgcheck => 0,
      require => File['rhel-server'];
    }
}
