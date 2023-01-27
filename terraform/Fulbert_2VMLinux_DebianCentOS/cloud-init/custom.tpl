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
