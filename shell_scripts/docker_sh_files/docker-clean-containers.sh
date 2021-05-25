sudo docker container rm --force $(sudo docker container ls --quiet)
sudo docker image rm $(sudo docker image ls --quiet)
