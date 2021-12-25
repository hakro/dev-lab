# Development lab

## Run the container

This Docker image comes preconfigured with a Vim config to make Go & Typescript development easy.

To use it, switch to your project directory, and run 

```console
docker run -it --name dev-lab -p 7000-7005:7000-7005 -v $PWD:/Projects hakimr/dev-lab bash
```

## Go Hot reloading

Air is included for Go hot reloading. To use it, you just need to run the command `air` inside a Go project directory

Air Doc : https://github.com/cosmtrek/air

## Useful commands & Shortcuts

- Open a terminal : `:term`
- Scroll in terminal : `ctrl+w Shift+n` Then use J&K to navigate, and i to go back
- Swap Split positions : `ctrl+w R`
- Move to new split : `ctrl+w w`
- Move to the split above : `ctrl+w k`
- Move to the split below : `ctrl+w j`
- Toogle NERDTree : `:NERDTreeToggle`
- Open file in new tab : `t`
- Close tab : `:tabclose`
- Create or delete file from NERDTree : `m then a or d`
- Go to next tab : `gt`
- Go to previous tab : `gT`
- Comment line : `gcc`
- Comment block in Visual Mode : `gc`
- Go to definition : `gd` (opens doc in new buffer)
- Go to back to the previous buffer : `ctrl+o`
- Go to back to the next buffer : `ctrl+i`
- Go to buffer number # : `:b#'
- Show open Vim buffers : `:ls` or `:buffers`
- Close buffer by number (number 3 here) : `:bd3`
