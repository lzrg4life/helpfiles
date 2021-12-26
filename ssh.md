# SSH Quickstart

```sh
# Creating an ssh key
ssh-keygen

# adding existing ssh keys
ssh-add --help

# listing added ssh keys
ssh-add -l 
```

## Adding an ssh key to a server

Add the line from id_rsa.pub to a new line in the `~/.ssh/authorized_keys` file

## Linux permissions for ssh

```
chmod 700 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa
```

## Windows

### Make sure the ssh agent is running

If it is not running you will get an error about connecting to the agent

1. open Services
2. locate "OpenSSH Authentication Agent"
3. right click on it -> properties
4. set "Startup type" to "Automatic"
5. click apply
6. then right click on it and "Start"