# DOWNLOAD DATA
wget https://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2019/Brasil/BR/br_unidades_da_federacao.zip

# CREATE WORKSPACE
curl --verbose -X POST -H "Content-Type: text/xml" --data "<workspace><name>geoserver_test</name></workspace>" --url 172.17.0.2:8080/geoserver/rest/workspaces --user admin:geoserver

# RETRIEVE WORKSPACE
#curl --verbose --url 172.17.0.2:8080/geoserver/rest/workspaces/geoserver_test --user admin:geoserver

# CREATE DATASTORE
curl --verbose -X PUT -H "Content-Type: application/zip" --data-binary @br_unidades_da_federacao.zip --url 172.17.0.2:8080/geoserver/rest/workspaces/geoserver_test/datastores/brazil_data4/file.shp --user admin:geoserver
rm br_unidades_da_federacao.zip

# RETRIEVE DATASTORE
#curl --verbose --url 172.17.0.2:8080/geoserver/rest/workspaces/geoserver_test/datastores/brazil_data --user admin:geoserver

# CREATE LAYER
curl --verbose --url -X POST --url 172.17.0.2:8080/geoserver/rest/workspaces/geoserver_test/datastores/brazil_data4/featuretypes --user admin:geoserver

# RETRIEVE LAYER
#curl --verbose --url 172.17.0.2:8080/geoserver/rest/layers/geoserver_test:Centralidade_2007 --user admin:geoserver

# SHOW MAP
#firefox "172.17.0.2:8080/geoserver/geoserver_test/wms?service=WMS&version=1.1.0&request=GetMap&layers=geoserver_test:BR_UF_2019&bbox=-73.990449969%2C-33.751177994%2C-28.847639914%2C5.271841077&width=768&height=663&srs=EPSG:4674&styles=&format=application/openlayers"
