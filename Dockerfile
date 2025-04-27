FROM ubuntu:25.04

ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

ARG NVIM_VERSION=v0.11.1
ARG USERNAME=hakim
ARG UID="1000"

COPY nvim /home/$USERNAME/.config/nvim
COPY bashrc /home/$USERNAME/.bashrc

RUN <<EOF
apt update && apt install -y --no-install-recommends \
ca-certificates jq git curl wget unzip sudo clang
rm -rf /var/lib/apt/lists/*

userdel ubuntu && rm -rf /home/ubuntu
useradd --create-home --uid $UID --shell /bin/bash $USERNAME
chown -R $USERNAME:$GROUP /home/$USERNAME
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Neovim
wget https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.tar.gz
tar -C /usr/local -xzf nvim-linux-x86_64.tar.gz && rm nvim-linux-x86_64.tar.gz
echo 'PATH=$PATH:/usr/local/nvim-linux-x86_64/bin' >> /home/$USERNAME/.bashrc
# /usr/local/nvim-linux-x86_64/bin/nvim --headless "+Lazy! install" +TSUpdate +qa

EOF

USER $USERNAME
WORKDIR /home/$USERNAME
