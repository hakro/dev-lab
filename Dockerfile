FROM debian:12-slim

ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

ARG USERNAME=hakim
ARG UID="1000"
ARG GROUP="root"

RUN apt update && apt install -y --no-install-recommends \
    ca-certificates git curl wget unzip \
    fd-find ripgrep clang #Needed by Nvim Telescope

# Create non root user
RUN useradd --create-home --uid $UID --gid $GROUP --shell /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY nvim /home/$USERNAME/.config/nvim
COPY bashrc /home/$USERNAME/.bashrc
RUN chown -R $USERNAME:$GROUP /home/$USERNAME

# Neovim
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz && \
    tar -C /usr/local -xzf nvim-linux64.tar.gz && rm nvim-linux64.tar.gz && \
    echo 'PATH=$PATH:/usr/local/nvim-linux64/bin' >> /home/$USERNAME/.bashrc && \
    /usr/local/nvim-linux64/bin/nvim --headless "+Lazy! install" +qa
    # /usr/local/nvim-linux64/bin/nvim --headless +TSUpdate +MasonUpdate +qa

USER $USERNAME
WORKDIR /home/$USERNAME
