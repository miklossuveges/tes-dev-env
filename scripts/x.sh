#!/bin/bash
source ~/.profile
source ~/.bashrc
echo "$(node -v)"
echo "$(npm -v)"
ln -s "$(which node)" /usr/bin/node;
export PATH="(which node)":$PATH;

npm i -g pm2 bosco nodemon;
mkdir -p /prj/team-dashboards;
# git clone 
