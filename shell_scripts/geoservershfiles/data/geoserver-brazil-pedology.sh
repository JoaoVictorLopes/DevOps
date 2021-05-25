# DOWNLOAD DATA
wget https://geoftp.ibge.gov.br/informacoes_ambientais/pedologia/vetores/escala_250_mil/versao_2019/Brasil_pedo_area.zip

# CREATE WORKSPACE
curl --verbose -X POST -H "Content-Type: text/xml" --data "<workspace><name>geoserver_test</name></workspace>" --url 172.17.0.2:8080/geoserver/rest/workspaces --user admin:geoserver

# RETRIEVE WORKSPACE
#curl --verbose --url 172.17.0.2:8080/geoserver/rest/workspaces/geoserver_test --user admin:geoserver

# CREATE DATASTORE
curl --verbose -X PUT -H "Content-Type: application/zip" --data-binary @Brasil_pedo_area.zip --url 172.17.0.2:8080/geoserver/rest/workspaces/geoserver_test/datastores/brazil_data2/file.shp --user admin:geoserver
rm Brasil_pedo_area.zip

# RETRIEVE DATASTORE
#curl --verbose --url 172.17.0.2:8080/geoserver/rest/workspaces/geoserver_test/datastores/brazil_data --user admin:geoserver

# CREATE LAYER
curl --verbose --url -X POST --url 172.17.0.2:8080/geoserver/rest/workspaces/geoserver_test/datastores/brazil_data2/featuretypes --user admin:geoserver

# RETRIEVE LAYER
#curl --verbose --url 172.17.0.2:8080/geoserver/rest/layers/geoserver_test:Centralidade_2007 --user admin:geoserver

# SHOW MAP
#firefox "http://172.17.0.2:8080/geoserver/geoserver_test/wms?service=WMS&version=1.1.0&request=GetMap&layers=geoserver_test:nyc_roads&bbox=984018.1663741902,207673.09513056703,991906.4970533887,219622.53973435296&width=506&height=768&srs=EPSG:2908&styles=&format=application/openlayers"
