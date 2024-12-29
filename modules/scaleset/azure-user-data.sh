#!/bin/bash
# Update system
sudo apt-get update -y
# Install NGINX
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo systemctl start ngin