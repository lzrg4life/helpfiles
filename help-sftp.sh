exit # don't accidentally run this!!

# Connect
sftp <user>@<server ip>

# Check what dir remote is in
pwd

# Moving around on the remote
cd <dir>

# Check what dir local is in
lpwd

# Moving around on the local
lcd <where the website is>

# Copy the directory up to the remote pwd
put -r <local dir>

# list sftp commands
?

# Copy file from remote to local
get <remote file> <save as>

# Copy directory from remote to local
get -r <directoy>
get -Pr <directory> # retain permissions with -P

# Upload a file or dir
put <local file>
put -r <local dir>

# if the error "Couldn't canonicalise: No such file or directory" occurs:
# create the destination directory

