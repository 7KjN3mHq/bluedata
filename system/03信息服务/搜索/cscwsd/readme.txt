README for cscwsd (C-Simpled Chinese Word Segment Daemon Server)

cscwsd 自述文件 (C版简易中文分词服务程序)

感谢您下载 cscwsd, 以下是关于本程序的一些简单介绍和描述. 完整的功能说明及相关
文档我们还在制作中, 请关注 http://php.twomice.net

1. 快速安装 (Linux/BSD ...)

  ./configure --prefix=/usr/local/cscwsd
  make
  make install

2. 使用
  cscwsd -h

  建议使用
  /usr/local/cscwsd/sbin/cscwsd -D -L /var/log/cscwsd.log -d /usr/local/cscwsd/etc/dict.txt

3. 简单测试分词
  telnet localhost 4700
 
  然后直接输入文字即可,每敲入一个回车,服务器立刻返回当前句的切分结果.
 
  几条控制命令,在切分前设定(可不设)
/set autodis=[on|off|yes|no]
/set ignore_mark=[on|off|yes|no]
/set delim=_

4. 编译选项 

  --enable-mio=[select|poll] 缺省是 poll
  --enable-mio-debug 打开 mio 的 debug 信息
  --enalbe-debug 打开主体程序的 debug 信息

... 待续