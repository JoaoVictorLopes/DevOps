# INSTALL
sudo apt update
sudo apt install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt update
sudo apt install mongodb-org --yes

# REMOVE
#sudo service mongod stop
#sudo apt-get purge mongodb-org*
#sudo rm -r /var/log/mongodb
#sudo rm -r /var/lib/mongodb
