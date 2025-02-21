FROM debian:12-slim

ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

ARG NVIM_VERSION=v0.10.4
ARG USERNAME=hakim
ARG UID="1000"
ARG GROUP="root"

RUN apt update && apt install -y --no-install-recommends \
    ca-certificates jq git curl wget unzip sudo \
    fd-find ripgrep clang #Needed by Nvim Telescope

# Create non root user
RUN useradd --create-home --uid $UID --gid $GROUP --shell /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY nvim /home/$USERNAME/.config/nvim
COPY bashrc /home/$USERNAME/.bashrc
RUN chown -R $USERNAME:$GROUP /home/$USERNAME

# Neovim
RUN wget https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.tar.gz  && \
    tar -C /usr/local -xzf nvim-linux-x86_64.tar.gz && rm nvim-linux-x86_64.tar.gz && \
    echo 'PATH=$PATH:/usr/local/nvim-linux-x86_64/bin' >> /home/$USERNAME/.bashrc && \
    /usr/local/nvim-linux-x86_64/bin/nvim --headless "+Lazy! install" +TSUpdate +qa
    # /usr/local/nvim-linux64/bin/nvim --headless +MasonUpdate +qa

USER $USERNAME
WORKDIR /home/$USERNAME
