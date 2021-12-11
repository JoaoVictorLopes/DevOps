# Instalar Docker Compose.
#sudo curl -L https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Atribuir permissão de execução.
sudo chmod +x /usr/local/bin/docker-compose

# Verificar instalação.
docker-compose --version

# Desinstalar Docker Compose.
#sudo rm /usr/local/bin/docker-compose
