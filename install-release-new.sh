#!/bin/bash
VER=`curl -s https://github.com/v2fly/v2ray-core/releases|grep /v2ray-core/releases/tag/|head -1|awk -F "[/]" '{print $6}'|awk -F "[>]" '{print $2}'|awk -F "[<]" '{print $1}'`
# VER="v4.28.4"
# rm -rf /tmp/Mywebtest/v2ray-linux-64.zip

DOWNLOAD_LINK="https://github.com/v2fly/v2ray-core/releases/download/${VER}/v2ray-linux-64.zip"
CONFIG_LINK="https://raw.githubusercontent.com/ly19811105/ray-kintohub/master/config.json"

mkdir -p /tmp/nginx
# Install nginx binary to /usr/bin/nginx
mkdir -p /usr/bin/nginx
mkdir -p /etc/nginx
curl -L -o "/tmp/nginx/nginx.zip" ${DOWNLOAD_LINK}
unzip "/tmp/nginx/nginx.zip" -d "/usr/bin/nginx/"
rm -rf /tmp/nginx/nginx.zip
curl -L -o "/etc/nginx/config.json" ${CONFIG_LINK}
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
# Create folder for nginx log
mkdir -p /var/log/nginx
ls /usr/bin/nginx/
mv /usr/bin/nginx/v2ray /usr/bin/nginx/nginx
rm -rf /usr/bin/nginx/v2ray
chmod +x "/usr/bin/nginx/nginx"
/usr/bin/nginx/nginx -config /etc/nginx/config.json
