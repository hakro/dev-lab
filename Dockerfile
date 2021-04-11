FROM golang:1.16-alpine

WORKDIR /root/.vim/pack/plugins/start

COPY vimrc /root/.vimrc
COPY bashrc /root/.bashrc

RUN mkdir -p /root/.vim/backup /root/.vim/swap /root/.vim/undo && \
    apk update && apk add vim bash git python3-dev npm g++ make cmake build-base linux-headers && \
    git clone https://github.com/itchyny/lightline.vim && \
    git clone https://github.com/tpope/vim-fugitive.git && \
    git clone https://github.com/scrooloose/nerdtree.git && \
    git clone https://github.com/ycm-core/YouCompleteMe.git && \
    cd YouCompleteMe && git submodule update --init --recursive && \
    python3 install.py --go-completer --ts-completer

# Need to make Lightline look nice
ENV TERM=xterm-256color

WORKDIR /app
