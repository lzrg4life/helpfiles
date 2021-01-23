exit # don't accidentally run this!!

# Tested on Ubuntu 16.04 and 18.04

# Log in as root
ssh root@<server ip>

# Update stuff
apt update
apt upgrade

# Reboot the server
reboot

# Create a non-root user
adduser webmaster

# Grant admin rights
usermod -aG sudo webmaster

# Copy SSH key from root to nonroot user
rsync --archive --chown=webmaster:webmaster ~/.ssh /home/webmaster

# Open new terminal and verify you can ssh as the nonroot user
ssh webmaster@<server ip>

# Disconnect as root user

# Verify that password authentication is off
sudo vim /etc/ssh/ssh_config
# look for "PasswordAuthentication", uncomment it, change yes to no

# Set up a basic firewall
sudo ufw status
sudo ufw app list # you should see OpenSSH
sudo ufw allow OpenSSH
sudo ufw enable 
# you will get a warning about disrupting active ssh sessions, this shouldn't be a problem

# Fix the hostname
sudo vim /etc/hostname
sudo vim /etc/hosts
# also make changes in the master file
sudo vim /etc/cloud/templates/hosts.debian.tmpl
sudo reboot

# Next Steps:
# Setup nginx
# Upload the website