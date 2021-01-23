# SSH Hosts

## Linux permissions for ssh

chmod 700 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa

## Creating an ssh key

ssh-keygen

## Adding an ssh key to a server

Add the line from id_rsa.pub to a new line in the ~/.ssh/authorized_keys file
