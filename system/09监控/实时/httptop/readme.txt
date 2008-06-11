yum -y install perl-Time-HiRes.i386

rpm -Uvh perl-File-Tail-0.99.3-1.2.el4.rf.noarch.rpm
rpm -Uvh perl-Term-ReadKey-2.30-2.el4.rf.i386.rpm

./httptop /var/log/apache/access_log.`date +%Y%m%d`
or
./httptop -f combined /var/log/apache/access_log.`date +%Y%m%d`

sort: h(Hits/s) t(Tot) l(Last) c(Client)
quit: q