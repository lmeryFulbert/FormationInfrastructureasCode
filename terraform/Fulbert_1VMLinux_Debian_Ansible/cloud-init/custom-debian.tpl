#cloud-config
hostname: ${vm_name}
fqdn: ${vm_name}.${vm_domain}

users:
  - name: ${vm_user}
    shell: /bin/bash
    ssh-authorized-keys:
      - ${vm_public_key}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    lock-passwd: false
    passwd: ${vm_password}

apt_update: true
packages:
  - git
  - ansible

runcmd:
  - [ git, clone, "https://github.com/lmeryFulbert/FormationInfrastructureasCode.git" ]
  - mkdir /etc/ansible
  - touch /etc/ansible/hosts
  - chmod 777 /etc/ansible/hosts
  - echo "localhost ansible_connection=local" >> /etc/ansible/hosts
  - [ ansible-playbook, "/FormationInfrastructureasCode/ansible/docbook/install-apache.yml" ]