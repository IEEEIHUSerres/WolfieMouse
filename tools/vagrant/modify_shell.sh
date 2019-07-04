#!/bin/sh

# For Vagrant provisioning - Check root and change to vagrant user
if [ $(id -u) = 0 ]; then
   USER='vagrant'
fi

# append .bashrc
echo -e "\n\nModifying .bashrc..."
sudo apt-get update
sudo apt-get -y install fortune cowsay
# Set bashrc
cat >> /home/$USER/.bashrc <<'EOF'
# Change console folder colors shard with windows
LS_COLORS="ow=01;36;40" && export LS_COLORS

# Cowsay
fortune | cowsay
EOF

# Set config.fish
mkdir -p /home/$USER/.config/fish
chown -R $USER:$USER /home/$USER/.config
cat >> /home/$USER/.config/fish/config.fish <<'EOF'
# Change console folder colors shard with windows
set -xU LS_COLORS "ow=01;36;40"

# Cowsay
fortune | cowsay
EOF

#echo -e '\n\n# Change console folder colors shard with windows\nLS_COLORS="ow=01;36;40" && export LS_COLORS\n\n# Cowsay\necho -e "WolfieMouse says:\n\n"$(fortune) | cowsay\n' >> /home/$USER/.bashrc
sed /home/$USER/.bashrc -e 's:\#force_color_prompt=yes:force_color_prompt=yes:g' -i
