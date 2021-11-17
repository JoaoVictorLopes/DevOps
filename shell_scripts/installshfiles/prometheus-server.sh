wget https://github.com/prometheus/prometheus/releases/download/v2.31.1/prometheus-2.31.1.linux-amd64.tar.gz
tar --extract --file prometheus-2.31.1.linux-amd64.tar.gz
echo '{\n  "metrics-addr" : "127.0.0.1:9323",\n  "experimental" : true\n}' > /etc/docker/daemon.json
echo '  - job_name: "docker"\n    static_configs:\n      - targets: ["localhost:9323"]\n' >> prometheus-2.31.1.linux-amd64/prometheus.yml
echo '  - job_name: "node"\n    static_configs:\n      - targets: ["localhost:9100"]\n' >> prometheus-2.31.1.linux-amd64/prometheus.yml
echo '  - job_name: "cadvisor"\n    scrape_interval: 5s\n    static_configs:\n      - targets:\n        - cadvisor:8080' >> prometheus-2.31.1.linux-amd64/prometheus.yml
cd prometheus-2.31.1.linux-amd64
./prometheus
