# Equinfra
#jmeter -Jthreads=20000 -Jloops=5 --nongui --reportatendofloadtests --testfile jmxfiles/equinfra.jmx --logfile log.txt --reportoutputfolder results/containers3_users20000_loops5
#rm log.txt jmeter.log

# GeoServer
#sudo docker container start geoserver
#sleep 1m
#jmeter -Jthreads=20 -Jloops=2 -Jip=172.17.0.2 -Jport=8080 --nongui --reportatendofloadtests --testfile jmxfiles/geoserver.jmx --logfile log.txt --reportoutputfolder results
#firefox results/index.html
#sleep 5m
#rm -rf jmeter.log log.txt results
#sudo docker container stop geoserver

# MapServer
jmeter -Jthreads=200 -Jloops=1 -Jip=172.17.0.2 -Jport=8080 --nongui --reportatendofloadtests --testfile jmxfiles/geoserver-rodovias-geojson.jmx --logfile log.txt --reportoutputfolder results/users200_loops1_rodada1
rm log.txt jmeter.log
sudo mv results/users200_loops1_rodada1 /var/www/html/tests-geo-servers/geoserver/consulta2/
