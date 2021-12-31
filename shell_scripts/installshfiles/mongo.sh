# INSTALL
sudo apt update
sudo apt install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update
sudo apt install mongodb-org --yes

# REMOVE
#sudo service mongod stop
#sudo apt  purge mongodb-org*
#sudo apt autoremove
#sudo rm -r /var/log/mongodb
#sudo rm -r /var/lib/mongodb
