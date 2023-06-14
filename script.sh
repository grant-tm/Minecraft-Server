#!/bin/bash

mkdir minecraft

# install java
sudo rpm --import https://yum.corretto.aws/corretto.key
sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
sudo yum install -y java-17-amazon-corretto-devel

# define directory structure and install minecraft server edition
sudo adduser serveradmin
sudo su
mkdir minecraft/server
cd minecraft/server
wget https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar

# start the server
java -Xmx1024M -Xms1024M -jar server.jar nogui
sed -i "s/^eula=false/eula=true/" eula.txt
java -Xmx1024M -Xms1024M -jar server.jar nogui

# set up crontab to restart the server if resources reboot
yum install cronie -y
sudo systemctl enable crond.service
sudo systemctl start crond.service
crontab -l > mycron
echo "@reboot cd minecraft/server; java -Xmx1024M -Xms1024M -jar server.jar nogui" > mycron
crontab mycron
rm mycron
