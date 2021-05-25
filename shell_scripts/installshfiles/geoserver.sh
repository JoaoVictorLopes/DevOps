# DOWNLOAD
#wget https://github.com/geoserver/geoserver/archive/2.18.2.zip
wget https://sourceforge.net/projects/geoserver/files/GeoServer/2.18.2/geoserver-2.18.2-bin.zip

# EXTRACT
sudo unzip geoserver-2.18.2-bin.zip -d /usr/share/geoserver

# CONFIGURE
export GEOSERVER_HOME=/usr/share/geoserver/
sudo chown -R victor /usr/share/geoserver/

# COMMENTS
# Start the applciation with $(sh startup.sh)
# Access the administration interface with localhost:8080/geoserver
# username: admin
# paswword: geoserver
