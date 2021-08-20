# Basics of sftp

This is enough to connect and upload/download files and folders.

Connecting
```sh
sftp username@server_ip
```

Commands
```sh
# List sftp commands
?

# Working Directory
pwd    # remote
lpwd   # local

# Change Directory
cd remote_path   # remote
lcd local_path   # local

# Copy local directory up to the remote pwd
put -r local_path

# Copying a single file from remote to local
get path_to_remote_file path_to_local_file

# Copying a directory from remote to local
# to retain permissions, do -Pr instead of -r
get -r path_to_remote_dir

# Upload a file
put path_to_local_file

# Upload a directory
put -r path_to_local_directory
```

## Error "Couldn't canonicalise: No such file or directory"

If the error "Couldn't canonicalise: No such file or directory" occurs then create the destination directory first.

