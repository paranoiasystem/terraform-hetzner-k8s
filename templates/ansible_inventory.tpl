[all:vars]
ansible_ssh_common_args='-o ProxyCommand="ssh -o StrictHostKeyChecking=no -i ${ssh_private_key_path} -W %h:%p -q root@${bastion_host_ip}"'
ansible_ssh_private_key_file=${ssh_private_key_path}

[controlplane]
%{ for name, ips in controlplane ~}
%{ for ip in ips ~}
${ip}
%{ endfor ~}
%{ endfor ~}

[worker]
%{ for name, ips in worker ~}
%{ for ip in ips ~}
${ip}
%{ endfor ~}
%{ endfor ~}
