#!/bin/bash

sudo cp bashrc ~/.bashrc
sudo cp aliases ~/.bash_aliases

sudo touch ~/.bash_custom

sudo cp sudo/sudoers /etc/sudoers.d/sudoers

sudo touch /etc/sudoers.d/custom
