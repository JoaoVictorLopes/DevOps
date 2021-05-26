docker swarm init
docker stack deploy --compose-file docker_compose_files/geoserver-docker-compose-for-swarm-on-gitpod.yml geoserver_stack
docker stack ls
docker service ls
docker container ls
