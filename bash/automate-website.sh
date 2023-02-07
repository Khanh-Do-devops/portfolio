#!/bin/bash

# This installs the wget zip unzip and httpd package. -y is auto install
sudo yum install wget zip unzip httpd -y

# Start and enable httpd service (webserver)
sudo systemctl start httpd
sudo systemctl enable httpd

#create a folder called webserver in the tmp directory, and cd into it
mkdir /tmp/webserver
cd /tmp/webserver/

# The website template link is passed through positional argument 1 where the file will downloaded and zipped
wget $1

# unzip the file - poitional argument 2
unzip -o /tmp/webserver/$2.zip

# the unzipped files are copied over to /var/www/html/ and the httpd service is restarted 
sudo cp -r $2/* /var/www/html/
sudo systemctl restart httpd

# This cleans up the zip file which is no longer needed.
sudo rm -rf /tmp/webserver/$2.zip

