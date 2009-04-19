#!/bin/bash
#Basic developer enviroment installation script for Ubuntu
#Developed by Marcelo Murad - email at marcelomurad dot com
#You can redistribute it and/or modify it under either the terms of the GPL (http://www.gnu.org/licenses/gpl-3.0.txt)

echo "Enable irb autocomplete"
echo "require 'irb/completion'" > ~/.irbrc

sudo apt-get -y install git-core

git clone git://github.com/lexrupy/gmate.git

cd gmate/

chmod u+x install.sh

sudo mkdir /usr/share/gedit-2/plugins/taglist

./install.sh

cd ..

cp -r developer_aux/gedit-2 ~/.gconf/apps/

