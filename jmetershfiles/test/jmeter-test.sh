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
jmeter -Jthreads=12800 -Jloops=2 -Jip=172.17.0.2 -Jport=8080 --nongui --reportatendofloadtests --testfile jmxfiles/geoserver-municipios-openlayers.jmx --logfile log.txt --reportoutputfolder results/users12800_loops2_rodada1
rm log.txt jmeter.log
sudo mv results/users12800_loops2_rodada1 /var/www/html/tests-geo-servers/geoserver-openlayers/consulta1/
