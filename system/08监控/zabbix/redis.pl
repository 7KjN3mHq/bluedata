#!/usr/bin/perl -w

#
## Copyright (C) 2009 Gleb Voronich <http://stanly.net.ua/>
##
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License
## as published by the Free Software Foundation; version 2 dated June,
## 1991.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
##
##
## $Log$
##
## Based on Redis module code v0.08 2009/from http://svn.rot13.org/index.cgi/Redis
##
## Installation process:
##
## 1. Download the plugin to your plugins directory (e.g. /usr/share/munin/plugins)
## 2. Create 3 symlinks at the directory that us used by munin for plugins detection (e.g. /etc/munin/plugins): redis_connected_clients, redis_per_sec and and redis_used_memory
## 3. Edit plugin-conf.d/munin-node if it is needed (env.host and  env.port variables are accepted)
## 4. Restart munin-node service

use strict;
use IO::Socket::INET;
use Switch;

my $HOST = $ARGV[0];
my $PORT = $ARGV[1];


my $server = "$HOST:$PORT";
my $sock = IO::Socket::INET->new(
    PeerAddr => $server,
    Proto => 'tcp'
);

print $sock "INFO\r\n";
my $result = <$sock> || die "can't read socket: $!";

my $rep;
read($sock, $rep, substr($result,1)) || die "can't read from socket: $!";

my $hash;
foreach (split(/\r\n/, $rep)) {
    my ($key,$val) = split(/:/, $_, 2);
    $hash->{$key} = $val;
}
close ($sock);

my $config = ( defined $ARGV[2] and $ARGV[2] eq "config" );


switch ($ARGV[2]) {
    case "blocked_clients" {
        print $hash->{'blocked_clients'};
    }
    case "connected_clients" {
        print $hash->{'connected_clients'};
    }
    case "connections_per_sec" {
        print $hash->{'total_connections_received'};
    }
    case "connected_slave" {
        print $hash->{'connected_slave'};
    }
    case "expired_keys" {
        print $hash->{'expired_keys'};
    }
    case "last_save_time" {
        print $hash->{'last_save_time'};
    }
    case "requests_per_sec" {
        print $hash->{'total_commands_processed'};
    }
    case "role" {
        print $hash->{'role'};
    }
    case "uptime_in_seconds" {
        print $hash->{'uptime_in_seconds'};
    }
    case "used_memory" {
        print $hash->{'used_memory'};
    }
    case "database" {
        my $dbs;
	my $total_dbs;
        foreach my $key (keys %{$hash}) {
            if ( $key =~ /^db\d+$/ && $hash->{$key} =~ /keys=(\d+),expires=(\d+)/ ) {
                $dbs->{$key} = [ $1, $2 ];
		$total_dbs++;
            }
        }
	print $total_dbs;
    }
    case "total_keys" {
        my $dbs;
	my $total_keys;
        foreach my $key (keys %{$hash}) {
            if ( $key =~ /^db\d+$/ && $hash->{$key} =~ /keys=(\d+),expires=(\d+)/ ) {
                $dbs->{$key} = [ $1, $2 ];
		$total_keys += $1;
            }
        }
	print $total_keys;
    }
    case "total_expires" {
        my $dbs;
	my $total_expires;
        foreach my $key (keys %{$hash}) {
            if ( $key =~ /^db\d+$/ && $hash->{$key} =~ /keys=(\d+),expires=(\d+)/ ) {
                $dbs->{$key} = [ $1, $2 ];
		$total_expires += $2;
            }
        }
	print $total_expires;
    }
    else {
	## case db[0-16]_keys && db[0-16]_expires
	if ($ARGV[2] =~ /^db(\d+)_(keys|expires)/) {
		my $db = $1;
		my $dbtype = $2;
        	my $dbs;
        	foreach my $key (keys %{$hash}) {
            		if ( $key =~ /^db(\d+)/){
				if ($db eq $1) {
					$hash->{$key} =~ /keys=(\d+),expires=(\d+)/ ;
					my $k = $1 || 0;
					my $e = $2;
					if ($dbtype eq "keys") {
						print $k;
					} else {
						print $e;
					}
				}
            		}
        	}
	}
    }
}

