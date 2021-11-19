# INSTALAR A PARTIR DE PACOTE .DEB
sudo apt install adduser libfontconfig1
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_8.2.5_amd64.deb
sudo dpkg --install grafana-enterprise_8.2.5_amd64.deb

# CONFIGURAR DATASOURCE
echo 'datasources:\n  - name: Prometheus\n    type: prometheus\n    access: proxy\n    url: http://localhost:9090\n  ' >> /etc/grafana/provisioning/datasources/sample.yaml

# EXECUTAR GRAFANA
#sudo systemctl start grafana-server
sudo service grafana-server start
