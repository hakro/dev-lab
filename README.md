# Development lab

## Run the container

This Docker image comes preconfigured with a Vim config to make Go & Typescript development easy.

To use it, switch to your project directory, and run 

```console
docker run -it --name dev-lab -p 7000-7005:7000-7005 -v $PWD:/Projects hakimr/dev-lab bash
```

If you need to run the container with a MariaDB and Adminer, you can use Docker Compose instead
```console
# Add -d to run in the background
docker compose up
# On another shell, get the DevLab Docker ID, and bash into it
docker ps
docker exec -it XXX bash
```

## Go Hot reloading

Air is included for Go hot reloading. To use it, you just need to run the command `air` inside a Go project directory

Air Doc : https://github.com/cosmtrek/air

## Useful commands & Shortcuts

- Open a terminal below : `:term`
- Open a terminal to the side : `:vert term`
- Run single Normal Mode command while in Insert Mode : `ctrl+o` then the command
- Normal Mode in terminal : `ctrl+\ ctrl+n`
- Swap Split positions : `ctrl+w r`
- Move to new split : `ctrl+w w`
- Move to the split above : `ctrl+w k`
- Move to the split below : `ctrl+w j`
- Close tab : `:tabclose`
- Show doc of thing under cursor : `shift+k` (repeat to get into the floating window)
- Show diagnostics on floating window : `gl` (repeat to get into the floating window)
- Go to next buffer : `tab`
- Go to previous buffer : `shift+tab`
- Comment line : `gcc`
- Comment block in Visual Mode : `gc`
- Go to definition : `gd` (opens doc in new buffer)
- Go to references : `gr`
- Go to back to the previous cursor position : `ctrl+o`
- Go to back to the next cursor position : `ctrl+i`
- Go to buffer number # : `:b#`
- Show open Vim buffers : `:ls` or `:buffers`
- Close buffer by number (number 3 here) : `:bd3`
