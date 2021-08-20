# Docker / Ubuntu Droplet Quickstart

Log in as root using the IP of the droplet
```sh
ssh root@<server ip>
```

Update stuff and reboot
```sh
apt update
apt upgrade
reboot
```

Create a non-root user
```sh
adduser webmaster
# Grant admin rights
usermod -aG sudo webmaster
# Copy SSH key from root to nonroot user
rsync --archive --chown=webmaster:webmaster ~/.ssh /home/webmaster

```


Open new terminal and verify you can ssh as the nonroot user
```sh
ssh webmaster@<server ip>
```

Disconnect as root user

Verify that password authentication is off
```sh
sudo vim /etc/ssh/ssh_config
# look for "PasswordAuthentication", uncomment it, change yes to no
```

Set up a basic firewall
```sh
sudo ufw status
sudo ufw app list # you should see OpenSSH
sudo ufw allow OpenSSH
sudo ufw enable 
# you might get a warning about disrupting active ssh sessions, this shouldn't be a problem
```

## Fixing the hostname

This is likely only needed if you changed the droplet's name after creation.

```sh
sudo vim /etc/hostname
sudo vim /etc/hosts
# also make changes in the master file
sudo vim /etc/cloud/templates/hosts.debian.tmpl
sudo reboot
```

## Next Steps

- Setup nginx
- Upload the website