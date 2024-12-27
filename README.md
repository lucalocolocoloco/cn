#config

apt update && apt install openvpn npm -y && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - &&  apt install -y nodejs 

#runing

npm init -y && npm install dotenv && npm start

#openvpnruning

openvpn --config filocn.filoch.ovpn
