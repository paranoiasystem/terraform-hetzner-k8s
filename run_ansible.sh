#!/bin/bash

terraform output -json ssh_public_key | jq -r . > ./ansible/public_key.pub
chmod 600 ./ansible/public_key.pub

terraform output -raw ssh_private_key > ./ansible/private_key.pem
chmod 600 ./ansible/private_key.pem

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i ./ansible/inventory ./ansible/playbooks/initial.yml

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i ./ansible/inventory ./ansible/playbooks/kube-cluster/kube-dependencies.yml

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i ./ansible/inventory ./ansible/playbooks/kube-cluster/master.yml

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i ./ansible/inventory ./ansible/playbooks/kube-cluster/worker.yml
