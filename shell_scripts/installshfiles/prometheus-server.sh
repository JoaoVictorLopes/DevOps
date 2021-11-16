wget https://github.com/prometheus/prometheus/releases/download/v2.31.1/prometheus-2.31.1.linux-amd64.tar.gz
tar --extract --file prometheus-2.31.1.linux-amd64.tar.gz
echo '  - job_name: "node"\n    static_configs:\n      - targets: ["localhost:9100"]\n' >> prometheus-2.31.1.linux-amd64/prometheus.yml
cd prometheus-2.31.1.linux-amd64
./prometheus
