
If just creating a new user with user interaction for the password, then the following script is run:

#!/bin/bash

echo "who is this user for ?"

read name

sudo useradd $name
sudo passwd $name

sudo usermod -aG wheel $name 

echo "User: $name has been created"




