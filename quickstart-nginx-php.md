# Quickstart for using PHP with nginx

To use nginx to host php, you need to use the package `php-fpm`

## Install

```sh
sudo add-apt-repository universe
sudo apt install php-fpm

# Check what version was installed, used later
ls /var/run/php/
# For instance: php7.2-fpm.sock
```

## Add php support to the nginx server block

Edit the server block you want to use php with

Make sure the fastcgi_pass has the right fpm version from above

```sh
sudo vim /etc/nginx/sites-available/sitename
```

Remove the old location block(s)

Set the php location block, using the php version that was installed:
```
location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
}
```

Deny .ht files:
```
location ~ /\.ht {
    deny all;
}
```

Check for syntax errors and reload
```sh
sudo nginx -t
sudo systemctl reload nginx
```

Test it
```sh
echo "<?php echo 'Hello from php';" >> /var/www/sitename/public/index.php
curl sitename
# you should see "Hello from php"
```

## Supporting emails from php

Referencing (this link)[https://www.digitalocean.com/community/questions/do-i-need-to-configure-anything-to-use-php-mail-function-on-fresh-lamp-install]

PHP uses sendmail by default, which is not installed by default on Digital Ocean Droplets.

Installing sendmail
```sh
sudo apt update
sudo apt upgrade -y
sudo apt install sendmail -y
# I don't think I needed this:
# export SMAIL=$(which sendmail)
```

Testing it sendmail
```sh
echo "Subject: sendmail test" | sendmail -v youremailaddress
```

Logging for sendmail is at: `sudo vim /var/log/mail.log`
