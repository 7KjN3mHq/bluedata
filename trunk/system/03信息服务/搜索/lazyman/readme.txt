libdb4.3 +
libxml2-2.6 +
python2.0 +

alien --to-deb lazyman-server-mysql-free-2.6-2.i386.rpm
dpkg -i lazyman-server-mysql-free_2.6-3_i386.deb

vi /etc/ld.so.conf
/usr/local/lazyman/lib/2.6
ldconfig

groupadd search
useradd -g search -d /usr/local/lazyman -s /bin/false search
chown -R search:search /usr/local/lazyman

cd /usr/local/lazyman
mkdir log log_index_times result
chown -R search:search /usr/local/lazyman

/usr/local/lazyman/bin/2.6/indexd_mysql -I
/usr/local/lazyman/bin/2.6/indexd_mysql -M
/usr/local/lazyman/bin/2.6/server_my

/usr/local/lazyman/bin/2.6/server_my: error while loading shared libraries: libstdc++.so.6: cannot open shared object file: No such file or directory
apt-get install libstdc++6

/usr/local/lazyman/bin/2.6/indexd_mysql: relocation error: /usr/local/lazyman/bin/2.6/indexd_mysql: undefined symbol: db_create
-- apt-get install libdb4.3
++ CentOS4.x: db4.i386
cd /usr/lib
mv libdb-4.2.so libdb-4.2.so~
scp CentOS4.x:/lib/libdb-4.2.so .

数据库操作发生错误 1193: Unknown system variable 'CLIENT_ENCODING', 执行命令SET CLIENT_ENCODING='ISO_8859-1'
vi /etc/indexd.cnf
#db_client_coding = SET CLIENT_ENCODING='ISO_8859-1'

dpkg -r lazyman-server-mysql-free
dpkg --purge lazyman-server-mysql-free


rpm2cpio lazyman-client-php4-2.6-2.i386.rpm | cpio -id

tar jxvf apinet.tar.bz2
mv apinet-2.6.so /usr/local/php/lib/php/extensions/
mv lazyman /usr/local/
vi /usr/local/php/etc/php.ini
extension_dir = "/usr/local/php/lib/php/extensions"
[apinet]
extension=apinet-2.6.so
apinet.trace_mode = off
apinet.search_ip = 192.168.0.1
apinet.search_port = 6667

/usr/local/php/bin/php search_test.php