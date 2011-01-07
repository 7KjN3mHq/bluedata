class anjuke::snmp
{
	package
	{ ["net-snmp"]:
	  ensure => present,
	}

	file
	{ "snmpd.conf":
	  name => "/etc/snmp/snmpd.conf",
	  ensure => present,
	  owner => root,
	  group => root,
	  mode => 644,
	  content => template("snmp/snmpd.conf.erb"),
	  require => Package["net-snmp"],
	}

	service
	{ snmpd:
          ensure => running,
          enable => true,
          hasrestart => true,
          hasstatus => true,
          require => Package["net-snmp"],
          subscribe => File["snmpd.conf"],
	}
}
