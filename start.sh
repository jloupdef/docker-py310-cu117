#!/bin/bash

echo "pod started"

if [[ $PUBLIC_KEY ]]
then
    sed -i "s/#PubkeyAuthentication.*/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
    sed -i "s/#PasswordAuthentication.*/PasswordAuthentication no/g" /etc/ssh/sshd_config
    sed -i "s/#AuthorizedKeysFile.*/AuthorizedKeysFile\t\.ssh\/authorized_keys/g" /etc/ssh/sshd_config
    sed -i "s/#PermitRootLogin.*/PermitRootLogin prohibit-password/g" /etc/ssh/sshd_config
    sed -i "s/#PermitEmptyPasswords.*/PermitEmptyPasswords no/g" /etc/ssh/sshd_config

    mkdir -p ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 644 -R ~/.ssh
    cd /
    service ssh start
fi

sleep infinity
