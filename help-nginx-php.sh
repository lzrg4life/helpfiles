exit # don't accidentally run this!!

# PHP for nginx: php-fpm

# You might need to add the repo
sudo add-apt-repository universe

sudo apt install php-fpm

# Verify what version was installed
ls /var/run/php/
# Latest: php7.2-fpm.sock

# Edit the server block you want to use php with
# Make sure the fastcgi_pass has the right fpm from above
sudo vim /etc/nginx/sites-available/<domain>.com
# remove the old location block
# set a location block:
# location ~ \.php$ {
#       include snippets/fastcgi-php.conf;
#       fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
# }

# Deny .ht files:
# location ~ /\.ht {
#       deny all;
# }

# Check for syntax errors and reload
sudo nginx -t
sudo systemctl reload nginx

# Test!
echo "<?php echo 'Hello from php';" >> /var/www/<domain>.com/html/index.php
