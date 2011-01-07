class anjuke::sudo
{
	package
	{ sudo:
	  ensure => present,
	}
	file
	{
		"/etc/sudoers":
		ensure	=> present,
		mode	=> 440,
		owner	=> root,
		group	=> root,
		content => template("sudo/rhel_sudoer.erb"),
		require => package["sudo"];
	}
}
