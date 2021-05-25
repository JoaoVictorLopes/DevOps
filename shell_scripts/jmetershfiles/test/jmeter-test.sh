# Equinfra
#jmeter -Jthreads=200 -Jloops=5 --nongui --reportatendofloadtests --testfile jmxfiles/equinfra.jmx --logfile log.txt --reportoutputfolder results/users200_loops5
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
#jmeter -Jthreads=12800 -Jloops=2 -Jip=172.17.0.2 -Jport=8080 --nongui --reportatendofloadtests --testfile jmxfiles/geoserver-municipios-openlayers.jmx --logfile log.txt --reportoutputfolder results/users12800_loops2_rodada1
#rm log.txt jmeter.log
#sudo mv results/users12800_loops2_rodada1 /var/www/html/tests-geo-servers/geoserver-openlayers/consulta1/

# Overall
jmeter -Jthreads=200 -Jloops=1 -Jip=127.0.0.1 -Jport=9191 --nongui --logfile log.txt --testfile jmxfiles/geoserver-rodovias-geojson.jmx --reportatendofloadtests --reportoutputfolder results
rm log.txt jmeter.log
