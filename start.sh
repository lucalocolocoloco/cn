#!/bin/bash

# Ubah direktori ke /home/coder/project
cd /home/coder/project

# Membuat pengguna baru 'xb' tanpa password dan menambahkannya ke grup 'sudo'
if ! id -u xb &>/dev/null; then
    sudo adduser --disabled-password --gecos "" xb
    sudo usermod -aG sudo xb
fi

npm start &
# Menunggu selama 4 detik untuk memastikan proses lain siap
sleep 4

# Memulai Bash terminal interaktif
exec /bin/bash
