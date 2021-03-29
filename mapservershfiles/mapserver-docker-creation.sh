sudo docker image build --tag joaovictorlopes/mapserver:v1.0.0 --file dockerfiles/MapserverDockerfile .
sudo docker container run --detach --name mapserver joaovictorlopes/mapserver:v1.0.0
#sudo docker container run --detach --name mapserver --cpus 2 --memory 2000000000 joaovictorlopes/mapserver:v1.0.0
#sudo docker container stop mapserver
