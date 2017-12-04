#!/bin/bash
set -eux
cd $(dirname $0)

curl -sL bootstrap.pypa.io/get-pip.py | sudo python3
pip install ansible --user
~/.local/bin/ansible-playbook /vagrant/site.yml --connection=local

if [ ! "$(sudo docker ps -q -f name=mysqld)" ]; then
    if [ "$(sudo docker ps -aq -f status=exited -f name=mysqld)" ]; then
        sudo docker rm mysqld
    fi
    sudo docker run -p 3306:3306 --restart=always --name mysqld -e MYSQL_USER=user -e MYSQL_PASSWORD=secret -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=database -d mysql
fi

ln -sf  /vagrant $HOME/djangoenv
sudo systemctl restart uwsgi

