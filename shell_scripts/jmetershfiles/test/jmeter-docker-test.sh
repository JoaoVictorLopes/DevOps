echo -n $GIT_TOKEN | xclip -selection clipboard
sudo docker container start geoserver
sudo docker run --name jmeter --cpus 2 --memory 2000000000 --interactive --tty joaovictorlopes/jmeter:v1.0.0
sudo docker container rm jmeter
sudo docker container stop geoserver
