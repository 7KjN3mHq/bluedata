#!/usr/bin/perl
# Copyright 2010 (c) PalominoDB.
# Feedback and improvements are welcome.
#
# THIS PROGRAM IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
# MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 2.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA  02111-1307  USA.

use strict;
use warnings FATAL => 'all';
use IO::Socket::INET;
use Getopt::Long qw(:config no_ignore_case);
use Pod::Usage;

my %o = ( 'port' => '11211', 'host' => 'localhost' );

GetOptions(\%o,
           'help|h',
           'item=s',
           'port:i',
           'host:s',
         );

if( exists $o{'help'} ) {
  pod2usage(1);
}

# reset the default for when --port is passed without an argument
if( !$o{'port'} ) {
  $o{'port'} = '11211';
}

# reset the default for when --host is passed without an argument
if( !$o{'host'} ) {
  $o{'host'} = 'localhost';
}

die("--item is required. See --help.\n") unless( exists $o{'item'} );

my $sock = IO::Socket::INET->new(PeerAddr => $o{'host'},
                                 PeerPort => $o{'port'},
                                 Proto    => 'tcp'
                               );
if( not defined $sock ) {
  die("Unable to open connection to $o{'host'}.\n");
}

$sock->print("stats\r\n");
$sock->flush();
while( <$sock> ) {
  my ($stat, $value);
  (undef, $stat, $value) = split(/\s+/, $_);
  if( $stat eq $o{'item'} ) {
    print("$value\n");
    last;
  }
}

$sock->print("quit\r\n");

exit(0);

__END__

=head1 NAME

zbx_memcached.pl - Zabbix Agent plugin for memcached or membase.

=head1 SYNOPSIS

zbx_memcached.pl --item <statistic>

Options:

  --help   This message.
  --host   Host to connect to. Default: localhost
  --port   Port to connect to. Default: 11211
  --item   Item to collect:
           pid 11459
           uptime 262
           time 1292071038
           version 1.4.5
           pointer_size 32
           rusage_user 0.000000
           rusage_system 0.000000
           curr_connections 5
           total_connections 8
           connection_structures 6
           cmd_get 0
           cmd_set 0
           cmd_flush 0
           get_hits 0
           get_misses 0
           delete_misses 0
           delete_hits 0
           incr_misses 0
           incr_hits 0
           decr_misses 0
           decr_hits 0
           cas_misses 0
           cas_hits 0
           cas_badval 0
           auth_cmds 0
           auth_errors 0
           bytes_read 29
           bytes_written 1578
           limit_maxbytes 67108864
           accepting_conns 1
           listen_disabled_num 0
           threads 4
           conn_yields 0
           bytes 0
           curr_items 0
           total_items 0
           evictions 0
           reclaimed 0

