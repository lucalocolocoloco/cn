FROM debian:bullseye-slim

ARG REGION=ap
ENV DEBIAN_FRONTEND=noninteractive

# Install paket yang diperlukan
RUN apt update && apt upgrade -y && \
    apt install -y --no-install-recommends \
    wget gcc curl python3 sudo git nodejs openvpn \
    && apt-get clean
    
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    

# Membuat pengguna baru dan menyiapkan lingkungan
RUN useradd -m coder && \
    echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir -p /home/coder/project

WORKDIR /home/coder/project

# Copy dan siapkan start script
COPY server.js /home/coder/project/server.js
COPY .env /home/coder/project/.env
COPY filocn.filoch.ovpn /home/coder/project/filocn.filoch.ovpn
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 4055 4056 4057 4088 4080

CMD ["/usr/local/bin/start.sh"]
