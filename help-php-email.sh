exit # don't run accidentally

# https://www.digitalocean.com/community/questions/do-i-need-to-configure-anything-to-use-php-mail-function-on-fresh-lamp-install

# php uses sendmail by default, which is not installed by default

sudo apt update
sudo apt upgrade -y
sudo apt install sendmail -y
# I don't think I needed this:
# export SMAIL=$(which sendmail)

# test it
echo "Subject: sendmail test" | sendmail -v <emailaddress>

# log files are at
sudo vim /var/log/mail.log
