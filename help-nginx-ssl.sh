exit # don't accidentally run this!!

# https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-18-04

# First, make sure your domain names are set up with
# two A records, one for <domain>.com and another for
# www.<domain>.com

# Add Certbot
sudo add-apt-repository ppa:certbot/certbot

# Install Certbot's nginx package
sudo apt install -y python-certbot-nginx

# Confirm the nginx server block has the correct domain name(s)
sudo vim /etc/nginx/sites-available/<sitename>.com

# Setup firewall to allow nginx
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'

# Verify the firewall settings
sudo ufw status

# Obtain an SSL Cert using Certbot
sudo certbot --nginx -d <sitename>.com -d www.<sitename>.com

# First time thru, will prompt for email address and TOS agreement
# It will ask if you want to redirect http traffic to https; you should do this

# Verify that Certbot will auto-renew the certs for you
sudo certbot renew --dry-run

# To test how good your SSL is, use https://www.ssllabs.com/ssltest/