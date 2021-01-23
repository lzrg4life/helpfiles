exit # don't accidentally run this!!

# install docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce # check that repo listed is the docker repo
sudo apt install docker-ce
# check that it is running
sudo systemctl status docker
# set up the current user to run docker without sudo
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG # confirm the user is in the docker group