apt-get install git-core -y
apt-get install build-essential debhelper make autoconf automake patch \
 dpkg-dev fakeroot pbuilder gnupg dh-make libssl-dev libpcre3-dev libmysqlclient-dev -y &&
git clone https://github.com/sphinxsearch/sphinx.git &&
cd sphinx &&
./configure --prefix=/usr/local/sphinx &&
make -j 4 install
