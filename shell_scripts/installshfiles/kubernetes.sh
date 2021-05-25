# Instalar Kubernetes.
curl -LO "https://storage.googleapis.com/kubernetes-release/release/\
$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

# Atribuir permissão de execução.
chmod +x ./kubectl

# Mover binário para a pasta padrão.
sudo mv ./kubectl /usr/local/bin/kubectl

# Verificar versão.
kubectl version --client

# Veriricar se virtualização é suportada no Linux.
grep -E --color 'vmx|svm' /proc/cpuinfo

# Adicionar repositório do VirtualBox.
sudo add-apt-repository "deb https://download.virtualbox.org/virtualbox/debian bionic contrib"

# Adicionar as chaves oficiais do VirtualBox.
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

# Atualizar repositórios do Ubuntu.
sudo apt update

# Instalar VirtualBox.
sudo apt install virtualbox-6.1

# Comandos quando as assinaturas do VirtualBox forem inválidas (BADSIGNATURE).
# sudo -s -H
# apt clean
# rm /var/lib/apt/lists/*
# rm /var/lib/apt/lists/partial/*
# apt-get clean
# apt-get update

# Instalar Minikube.
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube

# Adicionar binário ao PATH.
sudo mkdir --parents /usr/local/bin
sudo install minikube /usr/local/bin
