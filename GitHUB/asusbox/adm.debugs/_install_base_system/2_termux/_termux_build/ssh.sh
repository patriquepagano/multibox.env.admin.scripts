#!/bin/bash

pkg update
pkg install openssh

env > /sdcard/Download/termux.env.sh

touch ~/.ssh/authorized_keys
# Set Permissions to the file
chmod 600 ~/.ssh/authorized_keys
# Make sure the folder .ssh folder has the correct permissions
chmod 700 ~/.ssh

ssh-keygen

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys


