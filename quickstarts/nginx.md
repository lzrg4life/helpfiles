# Nginx Quickstart

## Initial setup

Install Nginx - Ubuntu
```sh
sudo apt update
sudo apt install -y nginx
```

Adjust the firewall
```sh
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status
```

Verify Nginx is running
```sh
systemctl status nginx
```

You should now be able to navigate to the server's IP address in a local browser and see the nginx home page.


## Adjust the nginx config

```sh
sudo vim /etc/nginx/nginx.conf
# Uncomment the "server_names_hash_bucket_size 64;" line
# Save and close the file

# Make sure there are no syntax errors in the configs
sudo nginx -t

# Restart nginx
sudo systemctl restart nginx
```


## Default website source

The default nginx website is hosted at `/var/www/html`

## Creating a new website

Set the sitename for use in the following sections
```sh
SITENAME="yoursitename.extension"
```

Create the folder for the site
```sh
sudo mkdir -p /var/www/$SITENAME/public
```

Give write permissions to the current user
```sh
sudo chown -R $USER:$USER /var/www/$SITENAME/
```

Make sure the umask value is still good
```sh
sudo chmod -R 755 /var/www
```

Create test pages to confirm stuff is working
```sh
echo "<h1>Hello from $SITENAME</h1>" >> /var/www/$SITENAME/public/index.html
```

Create the Nginx server blocks
```sh
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$SITENAME
# Edit the config
sudo vim /etc/nginx/sites-available/$SITENAME
# Remove the "default_server"
# Change the root to the "/var/www/sitename" dir
# Set the server_name values to "sitename.com www.sitename.com"
# Save and close the file
```

Make a symbolic link from sites-available to sites-enabled
```sh
sudo ln -s /etc/nginx/sites-available/$SITENAME /etc/nginx/sites-enabled/
```

Check for any errors
```sh
sudo nginx -t
```

Restart nginx
```sh
sudo systemctl restart nginx
```

## Testing

To test a named website without changing DNS records to point to the server:
1. Edit your local hosts file to point the domains to the new server
2. On windows the file to edit is: C:\Windows\System32\drivers\etc\hosts


## Doing a redirect in nginx

Enter the following in the nginx codeblock
```
location ~ \.html$ {
    return 301 $sheme://www.sitename.com/;
}
```

## Helpful commands for Nginx

```sh
sudo systemctl stop nginx
sudo systemctl start nginx
sudo systemctl restart nginx
sudo systemctl reload nginx # reloads config changes only
sudo systemctl disable nginx
sudo systemctl enable nginx
nginx -t # tests the configs for correct syntax
```
## Adding SSL

Based on (this Digital Ocean tutorial)[https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-18-04]

### Setup the A records

First, make sure your domain names are set up an `A` record for each url you want to have ssl on.

For example, to secure both sitename.com and www.sitename.com, you would need two `A` records:
- One for sitename.com
- Another for www.sitename.com

If you want to secure a subdomain, you'd need to have an `A` record for just the subdomain.

### Install Certbot

```sh
sudo add-apt-repository ppa:certbot/certbot
sudo apt install -y python-certbot-nginx
```

### Confirm the nginx server block has the correct domain name(s)

```sh
sudo vim /etc/nginx/sites-available/$SITENAME
```

### Setup firewall to allow full nginx

```sh
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'
# Verify the firewall settings
sudo ufw status
```

### Obtain an SSL Cert using Certbot

The first time through this will prompt for email address and agreement to the Terms of Service.

It will ask if you want to redirect http traffic to https. Normally you do want this.

```sh
sudo certbot --nginx -d sitename.com -d www.sitename.com
# Verify that Certbot will auto-renew the certs for you
sudo certbot renew --dry-run
```

### Testing SSL Quality

To test how good your SSL is, use https://www.ssllabs.com/ssltest/
