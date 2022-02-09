# Python

This assumes Python 3.6+.

## Starting a project

### Using the regular venv

```sh
# Create the project repo
mkdir ~/repos/myproject
cd ~/repos/myproject

# Create the environment
python -m venv env

# Switch to the environment
source env/bin/activate

# Switch back out of the environment
deactivate
```

### Using virtualenvwrapper

```sh
pip install virtualenvwrapper
# windows: pip install virtualenvwrapper-win
```