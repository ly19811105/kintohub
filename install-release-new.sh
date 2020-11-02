#!/bin/bash
v1="v"
v2="2"
v3="f"
v4="l"
v5="y"
v6="r"
v7="a"
add1=${v1}${v2}${v3}${v4}${v5}
add2=${v1}${v2}${v6}${v7}${v5}
VER=`curl -s https://github.com/${add1}/${add2}-core/releases|grep /${add2}--core/releases/tag/|head -1|awk -F "[/]" '{print $6}'|awk -F "[>]" '{print $2}'|awk -F "[<]" '{print $1}'`
# VER="v4.28.4"
DOWNLOAD_LINK="https://github.com/${add1}/${add2}-core/releases/download/${VER}/${add2}-linux-64.zip"
CONFIG_LINK="https://raw.githubusercontent.com/ly19811105/ray-kintohub/master/config2.json"

mkdir -p /tmp/nginx
# Install nginx binary to /usr/bin/nginx
mkdir -p /usr/bin/nginx
mkdir -p /etc/nginx
curl -L -o "/tmp/nginx/nginx.zip" ${DOWNLOAD_LINK}
unzip "/tmp/nginx/nginx.zip" -d "/usr/bin/nginx/"
rm -rf /tmp/nginx/nginx.zip
curl -L -o "/etc/nginx/config.json" ${CONFIG_LINK}
# test add BBR 
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
# Create folder for nginx log
mkdir -p /var/log/nginx
mv /usr/bin/nginx/${add2} /usr/bin/nginx/nginx
rm -rf /usr/bin/nginx/${add2}
chmod +x "/usr/bin/nginx/nginx"
/usr/bin/nginx/nginx -config /etc/nginx/config.json
