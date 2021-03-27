# APACHE
sudo apt install apache2
sudo a2enmod cgi

# REQUIRED
sudo apt install libgdal-dev libproj-dev libpng-dev libfreetype-dev libjpeg-dev zlib1g-dev libfcgi-dev libcairo2-dev libharfbuzz-dev libfribidi-dev libprotobuf-c-dev protobuf-c-compiler

# DOWNLOAD
wget https://download.osgeo.org/mapserver/mapserver-7.6.2.tar.gz

# EXTRACT
mkdir mapserver
tar --extract --file mapserver-7.6.2.tar.gz --directory mapserver
rm mapserver-7.6.2.tar.gz

# CONFIGURE
mkdir mapserver/mapserver-7.6.2/build
cd mapserver/mapserver-7.6.2/build
cmake -DCMAKE_INSTALL_PREFIX=/usr/share/mapserver \
	-DCMAKE_PREFIX_PATH=/usr/local/pgsql/91:/usr/local:/opt \
	-DWITH_CLIENT_WFS=ON \
	-DWITH_CLIENT_WMS=ON \
	-DWITH_CURL=ON \
	-DWITH_SOS=ON \
	-WITH_PHP=ON \
	-WITH_PHPNG=ON \
	../ > ../configure.out.txt

#	-DWITH_PERL=0 \
#	-DWITH_RUBY=0 \
#	-DWITH_JAVA=0 \
#	-DWITH_CSHARP=0 \
#	-DWITH_PYTHON=0 \
#	-DWITH_CAIRO=0 \
#	-DWITH_SVGCAIRO=0 \
#	-DWITH_ORACLESPATIAL=0 \
#	-DWITH_MSSQL2008=0 \
#	-DWITH_FCGI=0 \
#	-DWITH_HARFBUZZ=0 \
#	-DWITH_FRIBIDI=0 \
#	-DWITH_PROTOBUFC=0 \

# INSTALL
make
make install
sudo ln --symbolic /usr/share/mapserver/bin/mapserv /usr/lib/cgi-bin/mapserv

#sudo apt install php7.4-cli
