README for cscwsd (C-Simpled Chinese Word Segment Daemon Server)

cscwsd �����ļ� (C��������ķִʷ������)

��л������ cscwsd, �����ǹ��ڱ������һЩ�򵥽��ܺ�����. �����Ĺ���˵�������
�ĵ����ǻ���������, ���ע http://php.twomice.net

1. ���ٰ�װ (Linux/BSD ...)

  ./configure --prefix=/usr/local/cscwsd
  make
  make install

2. ʹ��
  cscwsd -h

  ����ʹ��
  /usr/local/cscwsd/sbin/cscwsd -D -L /var/log/cscwsd.log -d /usr/local/cscwsd/etc/dict.txt

3. �򵥲��Էִ�
  telnet localhost 4700
 
  Ȼ��ֱ���������ּ���,ÿ����һ���س�,���������̷��ص�ǰ����зֽ��.
 
  ������������,���з�ǰ�趨(�ɲ���)
/set autodis=[on|off|yes|no]
/set ignore_mark=[on|off|yes|no]
/set delim=_

4. ����ѡ�� 

  --enable-mio=[select|poll] ȱʡ�� poll
  --enable-mio-debug �� mio �� debug ��Ϣ
  --enalbe-debug ���������� debug ��Ϣ

... ����