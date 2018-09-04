test:
	ansible -i production.ini -m ping all

prepare:
	yum install centos-release-openstack-rocky epel-release -y
	yum install mariadb-server mariadb -y
	systemctl enable mariadb.service
	systemctl start mariadb.service
	yum install pdns pdns-backend-mysql -y
	mysql -u root < /vagrant/pdns.sql
	pip install ansible --upgrade

install:
	ansible-playbook -i production.ini master.yaml

retry:
	ansible-playbook -i production.ini master.yaml --limit @./master.retry

reset:
	ansible-playbook -i production.ini reset.yml