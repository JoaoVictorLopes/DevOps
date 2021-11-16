# CONFIGURAR DOCKER
echo '{"metrics-addr" "127.0.0.1:9323", "experimental" true}' > /etc/docker/daemon.json

# CONFIGURAR PROMETHEUS
echo '# my global config \n global: \n # Set the scrape interval to every 15 seconds. Default is every 1 minute. \n scrape_interval: 15s \n # Evaluate rules every 15 seconds. The default is every 1 minute. \n evaluation_interval: 15s \n # scrape_timeout is set to the global default (10s). \n # Attach these labels to any time series or alerts when communicating with \n # external systems (federation, remote storage, Alertmanager). \n external_labels: \n monitor: "codelab-monitor" \n # Load rules once and periodically evaluate them according to the global "evaluation_interval". \n rule_files: \n # - "first.rules" \n # - "second.rules" \n # A scrape configuration containing exactly one endpoint to scrape: \n # Here its Prometheus itself. \n scrape_configs: \n # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config. \n - job_name: "prometheus" \n # metrics_path defaults to "/metrics" \n # scheme defaults to "http". \n static_configs: \n - targets: ["localhost:9090"] \n - job_name: "docker" \n # metrics_path defaults to "/metrics" \n # scheme defaults to "http". \n static_configs: \n - targets: ["localhost:9323"]' > /tmp/prometheus.yml

# EXECUTAR PROMETHEUS
docker service create --replicas 1 --name my-prometheus --mount type=bind,source=/tmp/prometheus.yml,destination=/etc/prometheus/prometheus.yml --publish published=9090,target=9090,protocol=tcp prom/prometheus
