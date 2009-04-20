#!/bin/bash
#Gitorious enviroment installation script for Ubuntu
#Developed by Marcelo Murad - email at marcelomurad dot com
#You can redistribute it and/or modify it under either the terms of the GPL (http://www.gnu.org/licenses/gpl-3.0.txt)

if [ "$(whoami)" != "root" ]; then
echo "You need to be root to run this!"
  exit 2
fi

apt-get install -y librmagick-ruby libonig-dev libbluecloth-ruby libopenssl-ruby1.8

gem install textpow mime-types --no-ri --no-rdoc

gem install chronic --no-ri --no-rdoc
gem install ruby-openid -v2.1.2 --no-ri --no-rdoc

gem install ruby-yadis --no-ri --no-rdoc

apt-get install -y git-core

apt-get install -y aspell libaspell-dev aspell-en

apt-get install -y sendmail

adduser git --system --disabled-password

apt-get install -y libmagick9-dev

cd /srv

git clone git://gitorious.org/gitorious/mainline.git  gitorious

mkdir git_repositories

chown git:www-data git_repositories

chown -R git:www-data gitorious

cd gitorious

sed s/ssssht/`rake -s secret`/ config/gitorious.sample.yml >> config/gitorious.yml

#nano config/gitorious.yml
#repository_base_path: "/srv/git_repositories"
#gitorious_host: git.livingnet.com.br
sed s/repository_base_path/#repository_base_path/ config/gitorious.yml >> config/gitorious1.yml
sed s/gitorious_host/#gitorious_host/ config/gitorious1.yml >> config/gitorious2.yml
sed s/gitorious_client_port/#gitorious_client_port/ config/gitorious2.yml >> config/gitorious3.yml
sed s/gitorious_client_host/#gitorious_client_host/ config/gitorious3.yml >> config/gitorious4.yml
mv config/gitorious4.yml config/gitorious.yml
echo 'repository_base_path: "/srv/git_repositories"' >> config/gitorious.yml
echo 'gitorious_host: git.livingnet.com.br' >> config/gitorious.yml
echo 'gitorious_client_port: 80' >> config/gitorious.yml
echo 'gitorious_client_host: git.livingnet.com.br' >> config/gitorious.yml
rm config/gitorious1.yml config/gitorious2.yml config/gitorious3.yml



gem install hoe -v1.8.2 --no-ri --no-rdoc
yes | gem uninstall hoe -v1.12.2


gem install geoip -v0.8.0 --no-ri --no-rdoc
gem install daemons -v1.0.10 --no-ri --no-rdoc
gem install rspec-rails -v1.1.12 --no-ri --no-rdoc
gem install echoe -v3.0.2 --no-ri --no-rdoc
gem install RedCloth -v4.1.1 --no-ri --no-rdoc
gem install rdiscount -v1.3.1 --no-ri --no-rdoc
gem install rmagick -v2.8.0 --no-ri --no-rdoc

gem uninstall -v1.2.4 rspec
gem install diff-lcs --no-ri --no-rdoc

echo "CREATE DATABASE \`gitorious\` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;" > temp.mysql
mysql -uroot -p < temp.mysql
rm temp.mysql





echo "production:
  adapter: mysql
  database: gitorious
  username: root
  password: password
  host: localhost
  encoding: utf8" > config/database.yml

chown git:www-data config/database.yml



RAILS_ENV=production rake db:migrate

ln -s /srv/gitorious/script/gitorious /bin/gitorious

RAILS_ENV=production rake ultrasphinx:configure

gem install raspell --no-ri --no-rdoc
cp vendor/plugins/ultrasphinx/examples/ap.multi /usr/lib/aspell/

mkdir db/sphinx
touch db/sphinx/ap-stopwords.txt
RAILS_ENV=production rake ultrasphinx:spelling:build

touch log/gitorious_auth.log
touch log/production.log
touch log/tasks.log

chown -Rf git:www-data log/

echo "NameVirtualHost *
<VirtualHost *>
    ServerName git.livingnet.com.br
    DocumentRoot /srv/gitorious/public
</VirtualHost>" >> git.livingnet.com.br

mv git.livingnet.com.br /etc/apache2/sites-available
a2ensite git.livingnet.com.br

/etc/init.d/apache2 reload


###su git
###cd ~
###mkdir .ssh
###chmod 700 .ssh
###touch .ssh/authorized_keys
###chmod 640 .ssh/authorized_keys

###crontab -e
###*/5 * * * * /srv/gitorious/script/task_performer

###exit

