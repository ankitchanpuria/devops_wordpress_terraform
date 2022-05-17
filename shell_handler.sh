#!/bin/bash

# Shell handler for
# 1. Key Management
# 2. Ansible Installation.
# 3. Git handler
# 4. Playbook execution

project_dir="/home/ubuntu/project_dir"

key_manage () {
    

	sudo cp /home/ubuntu/id_rsa.pub /root/.ssh/id_rsa.pub
	sudo cp /home/ubuntu/id_rsa /root/.ssh/id_rsa
	sudo ssh-keyscan github.com >> /home/ubuntu/known_hosts

	sudo chown root:root /root/.ssh/id_rsa.pub
	sudo chown root:root /root/.ssh/id_rsa

	sudo chmod 400 /root/.ssh/id_rsa.pub
	sudo chmod 400 /root/.ssh/id_rsa

	sudo cat /home/ubuntu/id_rsa.pub >> /home/ubuntu/authorized_keys
	sudo cp /home/ubuntu/authorized_keys /root/.ssh/authorized_keys
	sudo cp /home/ubuntu/known_hosts /root/.ssh/known_hosts
	sudo chmod 600 /root/.ssh/known_hosts
	sudo chmod 600 /root/.ssh/authorized_keys

}

install_ansible () {

	sudo apt-get install -f --assume-yes   
 	sudo apt-get install software-properties-common --assume-yes
 	sudo apt-add-repository ppa:ansible\/ansible --yes
 	sudo apt-get update --assume-yes
 	sudo apt-get install ansible --assume-yes

}

git_handler (){
	cd $project_dir
	sudo git init 
	sudo git clone git@github.com:ankitchanpuria/devops_wordpress.git

}

create_inventory_execute_playbook (){
	cd /home/ubuntu
	sudo echo "[defaults]" >> ansible.cfg
    sudo echo "host_key_checking = False" >> ansible.cfg
	sudo echo "[wordpress]" >> hosts
	sudo echo "localhost" >> hosts
    sudo cp hosts $project_dir/devops_wordpress
    sudo cp ansible.cfg /etc/ansible/ansible.cfg
	sudo ansible-playbook -i hosts $project_dir/devops_wordpress/playbook.yml
}

key_manage
install_ansible
git_handler
create_inventory_execute_playbook


