# MongoDB DCU Failed.
wget https://github.com/dcu/mongodb_exporter/releases/download/v1.0.0/mongodb_exporter-linux-amd64
chmod +x mongodb_exporter-linux-amd64
./mongodb_exporter-linux-amd64 -mongodb.uri=localhost:27017
