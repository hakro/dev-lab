FROM golang:1.18.1-alpine

# Need to make Lightline look nice
ENV TERM=xterm-256color
ARG USERNAME=hakim
ARG UID="1000"
ARG GROUP="root"

COPY vimrc /home/$USERNAME/.vimrc
COPY bashrc /home/$USERNAME/.bashrc

# Create non root user
RUN adduser -D -H --uid $UID -G $GROUP -s /bin/bash $USERNAME && \
    mkdir -p /app /etc/sudoers.d && echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel && \
    adduser $USERNAME wheel && \
    apk update && apk add sudo vim bash git python3-dev npm curl g++ make cmake build-base linux-headers && \
    curl -sSfL https://raw.githubusercontent.com/cosmtrek/air/master/install.sh | sh -s -- -b $(go env GOPATH)/bin

USER $USERNAME
WORKDIR /home/$USERNAME/.vim/pack/plugins/start
RUN sudo mkdir -p /home/$USERNAME/.vim/backup /home/$USERNAME/.vim/swap /home/$USERNAME/.vim/undo/ /home/$USERNAME/.vim/pack/themes/start && \
    sudo chown -R $USERNAME:root /home/$USERNAME /app && \
    git clone --depth 1 https://github.com/itchyny/lightline.vim && \
    git clone --depth 1 https://github.com/jiangmiao/auto-pairs.git && \
    git clone --depth 1 https://github.com/tpope/vim-commentary && \
    git clone --depth 1 https://github.com/tpope/vim-fugitive.git && \
    git clone --depth 1 https://github.com/scrooloose/nerdtree.git && \
    git clone --depth 1 https://github.com/ycm-core/YouCompleteMe.git && \
    cd YouCompleteMe && git submodule update --depth 1 --init --recursive && \
    python3 install.py --go-completer --ts-completer && \
    cd /home/$USERNAME/.vim/pack/themes/start && \
    git clone --depth 1 https://github.com/dracula/vim.git dracula && \
    git clone --depth 1 https://github.com/kyoz/purify /tmp/purify && \
    mv /tmp/purify/vim /home/$USERNAME/.vim/pack/themes/start/purify && \
    rm -rf /tmp/purify

WORKDIR /Projects
