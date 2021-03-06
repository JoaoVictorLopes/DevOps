# Desinstalar versões anteriores.
sudo apt remove docker \
		docker-engine \
		docker.io \
		containerd \
		runc

# Atualizar repositórios do Ubuntu.
sudo apt update

# Instalar pacotes necessários.
sudo apt install apt-transport-https \
		ca-certificates \
		curl \
		gnupg \
		software-properties-common --yes

# Adicionar chave GPG oficial do Docker.
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Verificar os 8 caracteres finais da chave.
#sudo apt-key fingerprint 0EBFCD88

# Configurar repositório estável do Docker no Ubuntu.
#sudo add-apt-repository deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release --codename --short) stable'
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release --codename --short) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Configurar repositório estável do Docker no Mint.
#sudo add-apt-repository deb https://download.docker.com/linux/ubuntu focal stable'

# Atualizar repositórios do Ubuntu.
sudo apt update

# Instalar Docker.
sudo apt install docker-ce \
		docker-ce-cli \
		containerd.io --yes

# Verificar instalação do Docker.
sudo docker run hello-world

# Listar versões do Docker disponíveis.
#apt-cache madison docker-ce

# Instalar versão do Docker específica.
#sudo apt install docker-ce=VERSION_STRING docker-ce-cli=VERSION_STRING containerd.io

# Desinstalar Docker.
#sudo apt purge docker-ce docker-ce-cli containerd.io

# Remover imagens, contêineres e volumes.
#sudo rm -rf /var/lib/docker
#sudo rm -rf /var/lib/containerd
