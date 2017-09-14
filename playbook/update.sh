#!/bin/sh

# Launch the ansible playbook when necessary.

BO=$1

RESULT=ssh ansible@$BO sudo -u www-data /usr/local/bin/new_monarc_clients.sh | ./add_inventory.py ../inventory/
if [ $RESULT -eq 0 ]; then
    echo 'New clients detected. Running ansible-playbook...'
    ansible-playbook -i ../inventory/ monarc.yaml --user ansible
fi

RESULT=ssh ansible@$BO sudo -u www-data /usr/local/bin/del_monarc_clients.sh | ./del_inventory.py ../inventory/
if [ $RESULT -eq 0 ]; then
    echo 'Client deleted. Running ansible-playbook...'
    ansible-playbook -i ../inventory/ monarc.yaml --user ansible
fi