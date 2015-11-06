apt-get install build-essential debhelper make autoconf automake patch \
 dpkg-dev fakeroot pbuilder gnupg dh-make libssl-dev libpcre3-dev -y
git clone https://github.com/alibaba/tengine.git
cd tengine
mv packages/debian .
DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage -rfakeroot -uc -b
dpkg tengine_*
rm -rf tengine*

apt-get install cmake gcc libaio-dev libncurses5-dev libreadline-dev bison perl -y
git clone https://github.com/webscalesql/webscalesql-5.6.git
cd webscalesql*
groupadd mysql
useradd -r -g mysql mysql
cmake .
make
make install
cd /usr/local/mysql
chown -R mysql .
chgrp -R mysql .
/usr/local/mysql/scripts/mysql_install_db -defaults-file=/usr/local/mysql/my.cnf --user=mysql

apt-get install gfortran

wget http://www.fastcgi.com/dist/fcgi.tar.gz
tar -xzf fcgi.tar.gz
cd fcgi*
./configure
make
make install

