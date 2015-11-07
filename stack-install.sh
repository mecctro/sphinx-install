apt-get install git-core -y
apt-get install build-essential debhelper make autoconf automake patch \
 dpkg-dev fakeroot pbuilder gnupg dh-make libssl-dev libpcre3-dev -y &&
git clone https://github.com/alibaba/tengine.git &&
cd tengine &&
mv packages/debian . &&
DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage -rfakeroot -uc -b &&
dpkg -i ../tengine_*.deb &&
rm -rf /etc/init.d/tengine &&
cp debian/init.d /etc/init.d/nginx &&
chmod 775 /etc/init.d/nginx &&
update-rc.d nginx defaults &&
service nginx restart &&
cd ../ &&
rm -rf tengine* ;

apt-get install cmake gcc libaio-dev libncurses5-dev libreadline-dev bison perl -y &&
git clone https://github.com/webscalesql/webscalesql-5.6.git &&
cd webscalesql* &&
groupadd mysql &&
useradd -r -g mysql mysql &&
cmake . &&
make &&
make install &&
cd /usr/local/mysql &&
chown -R mysql . &&
chgrp -R mysql . &&
sed -i 's|datadir.*|datadir         = /usr/local/mysql/data|g' /etc/mysql/my.cnf &&
sed -i 's|lc-messages-dir.*|lc-messages-dir = /usr/local/mysql/share|g' /etc/mysql/my.cnf &&
sudo /usr/local/mysql/scripts/mysql_install_db -defaults-file=/usr/local/mysql/my.cnf --user=mysql &&
mv support-files/mysql.server /etc/init.d/mysql &&
chmod 775 /etc/init.d/mysql &&
update-rc.d mysql defaults &&
service mysql restart &&
cd ../ &&
ln -s /usr/local/mysql/bin/* /usr/bin &&
rm -rf webscalsql* ;

apt-get install gfortran -y ;

wget http://www.fastcgi.com/dist/fcgi.tar.gz &&
tar -xzf fcgi.tar.gz &&
cd fcgi* &&
./configure &&
make &&
make install &&
cd ../ &&
rm -rf fcgi* ;

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 &&
echo deb http://dl.hhvm.com/debian wheezy main | sudo tee /etc/apt/sources.list.d/hhvm.list &&
apt-get update &&
apt-get install hhvm -y &&
update-rc.d hhvm defaults &&
/usr/share/hhvm/install_fastcgi.sh &&
sed -i 's/9000/8000/g' /etc/hhvm/server.ini &&
sed -i 's/9000/8000/g' /etc/nginx/hhvm.conf &&
sed -i 's/9000/8000/g' /etc/nginx/conf.d/default.conf &&
sed -i 's/fastcgi_param.*SCRIPT_FILENAME.*/fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;/g' \
 /etc/nginx/conf.d/default.conf &&
echo 'fastcgi_keep_conn on;' >> /etc/nginx/fastcgi.conf &&

apt-get install php5-fpm -y ;
