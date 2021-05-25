sudo docker image build --tag joaovictorlopes/geoserver:v1.0.0 --file dockerfiles/GeoserverDockerfile .
sudo docker container run --detach --name geoserver --cpus 2 --memory 2000000000 joaovictorlopes/geoserver:v1.0.0
sh geoservershfiles/data/geoserver-nyc-roads.sh
sh geoservershfiles/data/geoserver-brazil-uf.sh
sh geoservershfiles/data/geoserver-brazil-pedology.sh
sudo docker container stop geoserver
