#!/bin/bash

# Launch the ansible playbook when necessary.
# Launch this file with cron (as the user 'ansible')

PLAYBOOK_PATH=$1
BO=$2

ANSIBLE_PATH="/usr/local/bin/ansible-playbook"

cd $PLAYBOOK_PATH

RESULT=`ssh ansible@$BO sudo -u www-data /usr/local/bin/new_monarc_clients.sh | jq -s . | ./add_inventory.py ../inventory/`
if [ "$RESULT" = "0" ]; then
    echo 'New clients detected. Running ansible-playbook...'
    $ANSIBLE_PATH -i ../inventory/ monarc.yaml --user ansible
fi

RESULT=`ssh ansible@$BO sudo -u www-data /usr/local/bin/del_monarc_clients.sh | jq -s . | ./del_inventory.py ../inventory/`
if [ "$RESULT" = "0" ]; then
    echo 'Client deleted. Running ansible-playbook...'
    $ANSIBLE_PATH -i ../inventory/ monarc.yaml --user ansible
fi
