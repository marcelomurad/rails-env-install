#!/bin/bash
#Basic rails enviroment installation script for Ubuntu
#Developed by Marcelo Murad - email at marcelomurad dot com
#You can redistribute it and/or modify it under either the terms of the GPL (http://www.gnu.org/licenses/gpl-3.0.txt)

#separated by space
ADDITIONAL_PACKAGES="mc"
ADDITIONAL_GEMS="rspec"

sudo apt-get update

sudo apt-get install -y ssh ruby ruby1.8-dev ruby-pkg-tools rdoc ri irb sqlite3 libopenssl-ruby libsqlite3-ruby sqlitebrowser

sudo apt-get install -y wget

sudo apt-get install -y $ADDITIONAL_PACKAGES

mkdir temp_install_rails_env

wget http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz -Otemp_install_rails_env/rubygems-1.3.1.tgz

tar -xf temp_install_rails_env/rubygems-1.3.1.tgz

cd rubygems-1.3.1

sudo ruby setup.rb

sudo ln -s /usr/bin/gem1.8 /usr/bin/gem

sudo gem install rails -no-ri -no-rdoc

sudo gem install $ADDITIONAL_GEMS
