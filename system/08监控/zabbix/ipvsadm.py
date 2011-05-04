#!/bin/env python
# -*- coding: utf-8 -*-
#
# usage: ipvsadm.py acctiveconn tcp 172.18.0.12:80 172.17.0.22:80
import sys

def parserArgs(args):
    p = dict()
    if args[1] not in ('active', 'inactive') :
        print 'type error'
        sys.exit(1)
    p['type'] = args[1]
    p['proto'] = args[2].upper()
    vip = args[3].split(':')
    p['vipHex'] = ipToHexStr(vip[0])
    p['vipPort'] = '%04X' % int(vip[1])
    rip = args[4].split(':')
    p['ripHex'] = ipToHexStr(rip[0])
    p['ripPort'] = '%04X' % int(rip[1])
    #print p
    return p

def ipToHexStr(ip):
    buf=list()
    for i in ip.split('.'):
        buf.append('%02X' % int(i))

    return "".join(buf)

def findData(args):
    vip = "%s  %s:%s" % (args['proto'], args['vipHex'], args['vipPort'])
    rip = "  -> %s:%s" % (args['ripHex'], args['ripPort'])
    vipStr = None
    result = None
    for line in file("/proc/net/ip_vs"):
        if line.startswith(vip):
            vipStr = True
            continue
        if vipStr is True and line.startswith(rip):
            break
    #  -> AC110016:0050      Masq    1      10         157
    import re
    values = re.split('\s+', line)
    #print values
    # ['', '->', 'AC110016:0050', 'Masq', '1', '0', '0', '']
    result = dict()
    result['weight'] = values[4]
    result['active'] = values[5]
    result['inactive'] = values[6]
    return result[args['type']]

if __name__ == "__main__":
    args = parserArgs(sys.argv)
    print findData(args)

