exit # don't accidentally run this!!

# Install Nginx
sudo apt update
sudo apt install -y nginx

# Adjust the firewall
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status

# Verify Nginx is running
systemctl status nginx

# Try opening the homepage from a browser

# Helpful commands for Nginx
sudo systemctl stop nginx
sudo systemctl start nginx
sudo systemctl restart nginx
sudo systemctl reload nginx # reloads config changes only
sudo systemctl disable nginx
sudo systemctl enable nginx
nginx -t

# Default nginx website
/var/www/html

# Create a new websites
sudo mkdir -p /var/www/<sitename>.com/public

# Give write permissions to the current user
sudo chown -R $USER:$USER /var/www/<sitename>.com/

# Make sure the umask value is still good
sudo chmod -R 755 /var/www

# Create test pages to confirm stuff is working
echo "<h1>Hello from <sitename>.com</h1>" >> /var/www/<sitename>.com/public/index.html

# Create the server blocks
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/<sitename>.com
# Edit the config
sudo vim /etc/nginx/sites-available/<sitename>.com
# Remove the "default_server"
# Change the root to the "/var/www/<sitename>.com/public" dir
# Set the server_name values to "<sitename>.com www.<sitename>.com"
# Save and close the file

# Make a symbolic link from sites-available to sites-enabled
sudo ln -s /etc/nginx/sites-available/<sitename>.com /etc/nginx/sites-enabled/

# Adjust the nginx config
sudo vim /etc/nginx/nginx.conf
# Uncomment the "server_names_hash_bucket_size 64;" line
# Save and close the file

# Make sure there are no syntax errors in the configs
sudo nginx -t

# Restart nginx
sudo systemctl restart nginx

# Test!
# To test without changing the domains to point to the server:
#   edit your local hosts file to point the domains to the new server
#   On windows the file to edit is: C:\Windows\System32\drivers\etc\hosts


# to do a redirect:
# location ~ \.html$ {
#       return 301 $sheme://www.<sitename>.com/;
# }
#