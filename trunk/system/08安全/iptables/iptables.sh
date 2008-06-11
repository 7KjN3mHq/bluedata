#!/bin/sh

##Config
IPTABLES="/sbin/iptables"
EXT_IFACE="eth0"
WHITELIST="127.0.0.1 219.153.35.30"
BLACKLIST="219.153.14.150"
ALLOWED="22 80"

##Init
# Load Modules
/sbin/modprobe ip_tables
/sbin/modprobe ip_conntrack
# Reset Rules
$IPTABLES -F
$IPTABLES -X

##Setting
for ip in $WHITELIST; do
  echo "Permitting $ip..."
  $IPTABLES -A INPUT -i $EXT_IFACE -s $ip -j ACCEPT
done

for ip in $BLACKLIST; do
  echo "Blocking $ip..."
  $IPTABLES -A INPUT -i $EXT_IFACE -s $ip -j DROP
done

# PREVENT HTTPDOS
#$IPTABLES -N HTTPDOS
#$IPTABLES -A HTTPDOS -i $EXT_IFACE -p tcp --dport 80 -m limit --limit 12/s --limit-burst 24 -j RETURN
#$IPTABLES -A HTTPDOS -i $EXT_IFACE -p tcp --dport 80 -j REJECT --reject-with tcp-reset
#$IPTABLES -A INPUT -i $EXT_IFACE -p tcp --dport 80 -m state --state NEW -j HTTPDOS
##Note: Hardware Firewall Bug

for port in $ALLOWED; do
  echo "Accepting port $port..."
  $IPTABLES -A INPUT -i $EXT_IFACE -p tcp --dport $port -j ACCEPT
done

##PREVENT PORT SCAN
# NMAP FIN/URG/PSH
$IPTABLES -A INPUT -i $EXT_IFACE -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP

# Xmas Tree
$IPTABLES -A INPUT -i $EXT_IFACE -p tcp --tcp-flags ALL ALL -j DROP

# Another Xmas Tree
$IPTABLES -A INPUT -i $EXT_IFACE -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP

# Null Scan(possibly)
$IPTABLES -A INPUT -i $EXT_IFACE -p tcp --tcp-flags ALL NONE -j DROP

# SYN/RST
$IPTABLES -A INPUT -i $EXT_IFACE -p tcp --tcp-flags SYN,RST SYN,RST -j DROP

# SYN/FIN -- Scan(possibly)
$IPTABLES -A INPUT -i $EXT_IFACE -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP

##PREVENT SYN FLOOD
$IPTABLES -N SYNFLOOD
$IPTABLES -A SYNFLOOD -i $EXT_IFACE -p tcp --syn -m limit --limit 1/s -j RETURN
$IPTABLES -A SYNFLOOD -i $EXT_IFACE -p tcp -j REJECT --reject-with tcp-reset
$IPTABLES -A INPUT -i $EXT_IFACE -p tcp -m state --state NEW -j SYNFLOOD

##PREVENT PING FLOOD ATTACK
# Drop
#$IPTABLES -A INPUT -i $EXT_IFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
#$IPTABLES -A INPUT -i $EXT_IFACE -m state --state NEW,INVALID -j DROP
# Limit
$IPTABLES -N PING
$IPTABLES -A PING -i $EXT_IFACE -p icmp --icmp-type echo-request -m limit --limit 1/second -j RETURN
$IPTABLES -A PING -i $EXT_IFACE -p icmp -j REJECT
$IPTABLES -I INPUT -i $EXT_IFACE -p icmp --icmp-type echo-request -m state --state NEW -j PING

##Drop All Packets
$IPTABLES -A INPUT -i $EXT_IFACE -p tcp --syn -j DROP

##PREVENT IP SPOOF
echo "1" > /proc/sys/net/ipv4/conf/$EXT_IFACE/rp_filter
echo "1" > /proc/sys/net/ipv4/conf/$EXT_IFACE/log_martians

##Save
echo "0" > /proc/sys/net/ipv4/conf/all/accept_redirects
echo "0" > /proc/sys/net/ipv4/conf/all/accept_source_route

##PREVENT DOS
echo "1" > /proc/sys/net/ipv4/tcp_syncookies
echo "1" > /proc/sys/net/ipv4/tcp_syn_retries
echo "1" > /proc/sys/net/ipv4/tcp_synack_retries
echo "8192" > /proc/sys/net/ipv4/tcp_max_syn_backlog

##IP CONNTRACK TCP TIMEOUT ESTABLISHED(Linux 2.6)
echo "300" > /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_established