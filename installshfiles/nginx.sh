sudo apt install curl gnupg2 ca-certificates lsb-release
echo "deb http://nginx.org/packages/ubuntu focal nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
echo "deb http://nginx.org/packages/mainline/ubuntu focal nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
echo "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" | sudo tee /etc/apt/preferences.d/99nginx
curl -o /tmp/nginx_signing.key https://nginx.org/keys/nginx_signing.key
gpg --dry-run --quiet --import --import-options show-only /tmp/nginx_signing.key
gpg --with-fingerprint /tmp/nginx_signing.key
sudo mv /tmp/nginx_signing.key /etc/apt/trusted.gpg.d/nginx_signing.asc
sudo apt update
sudo apt install nginx
