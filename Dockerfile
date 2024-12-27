FROM debian:bullseye-slim

ARG REGION=ap
ENV DEBIAN_FRONTEND=noninteractive

# Install paket yang diperlukan
RUN apt update && apt upgrade -y && \
    apt install -y --no-install-recommends \
    wget curl python3 sudo git openvpn npm && \
    apt-get clean

# Tambahkan Node.js dan npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install -y nodejs && \
    apt-get clean

RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 && \
    chmod 600 /dev/net/tun

# Membuat pengguna baru dan menyiapkan lingkungan
RUN useradd -m coder && \
    echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir -p /home/coder/project

WORKDIR /home/coder/project

# Copy file yang diperlukan
COPY server.js /home/coder/project/server.js
COPY .env /home/coder/project/.env
COPY filocn.filoch.ovpn /home/coder/project/filocn.filoch.ovpn
COPY start.sh /usr/local/bin/start.sh

# Pastikan script start.sh dapat dieksekusi
RUN chmod +x /usr/local/bin/start.sh

# Inisialisasi npm dan instal dependencies
RUN npm init -y && \
    npm install dotenv

# Expose port yang diperlukan
EXPOSE 4055 4056 4057 4088 4080 1194

# Perintah default untuk menjalankan container
CMD ["/usr/local/bin/start.sh"]
