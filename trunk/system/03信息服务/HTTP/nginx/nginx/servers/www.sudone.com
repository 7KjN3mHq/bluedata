server {
include port.conf;
server_name www.sudone.com sudone.com;
include location.conf;

location / {
proxy_pass http://www.sudone.com;
include proxy.conf;
include rewrite.conf;
}

}