class anjuke::adduser {
    define add_user ($username='', $useruid='', $userhome='', $usershell='/bin/bash', $groups)
    {
        user
        {   $username:
            uid   => $useruid,
            shell => $usershell,
            groups => $groups,
            home  => "/home/$userhome",
        }
        file 
        {   "/home/$userhome":
            owner   => $useruid,
            group   => $useruid,
            mode    => 700,
            ensure  => directory;
        }
        file
        {   "/home/$userhome/.ssh":
            owner   => $useruid,
            group   => $useruid,
            mode    => 700,
            ensure  => directory,
            require => File["/home/$userhome"];
        }
        file
        {   "/home/$userhome/.ssh/authorized_keys":
            owner   => $useruid,
            group   => $useruid,
            mode    => 600,
            ensure  => present, 
            content => template("users/${userhome}_authorized_keys.erb"),
            require => File["/home/$userhome/.ssh"]; 
        }
    }
}
