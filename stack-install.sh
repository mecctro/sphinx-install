apt-get install build-essential debhelper make autoconf automake patch \
 dpkg-dev fakeroot pbuilder gnupg dh-make libssl-dev libpcre3-dev -y
git clone https://github.com/alibaba/tengine.git
cd tengine
mv packages/debian .
DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage -rfakeroot -uc -b
dpkg tengine_*
cp packages/debian/init.d /etc/init.d/nginx
update-rc.d nginx defaults
service nginx restart
cd ../
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
mv support-files/mysql.server /etc/init.d/mysql
chmod 775 /etc/init.d/mysql
update-rc.d mysql defaults
service mysql restart
cd ../
rm -rf webscalsql*

apt-get install gfortran

wget http://www.fastcgi.com/dist/fcgi.tar.gz
tar -xzf fcgi.tar.gz
cd fcgi*
./configure
make
make install

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
echo deb http://dl.hhvm.com/debian wheezy main | sudo tee /etc/apt/sources.list.d/hhvm.list
apt-get update
apt-get install hhvm -y

