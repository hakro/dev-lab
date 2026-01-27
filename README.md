# Development lab

## Run the container

This Docker image comes preconfigured with a Vim config to make Go & Typescript development easy.

To use it, switch to your project directory, and run 

```console
docker run -it --name dev-lab -p 7000-7005:7000-7005 -v $PWD:/home/hakim/Projects hakrou/dev-lab
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
- Paste into terminal from `"` registry : `ctrl+w ""` (Terminal needs to be in insert mode)
- Run single Normal Mode command while in Insert Mode : `ctrl+o` then the command
- Normal Mode in terminal : `ctrl+\ ctrl+n`
- Search history in Ex command mode: `ctrl+f` (or `q:` in Normal mode )
- Move to beginning and end of Visual selection: `o`
- Reselect last visually selected block: `gv`
- Align spaces between types and variable names: `:!column -t`

- Go to next buffer : `tab`
- Go to previous buffer : `shift+tab`

- Netrw open file in previously selected split: `shift+p`
- Netrw open file in vertical split: `v`

- Windown commands help: `:h CTRL+W`
- Open help in a new tab: `:tab h xxx`
- Show open Vim buffers : `:ls` or `:buffers`
- Go to buffer number # : `:b#`
- Close buffer by number (number 3 here) : `:bd3`
- Close multiple buffers by number : `:bd 3 5 10`
- Swap Split positions : `ctrl+w r`
- Move split around : `ctrl+w HJKL` (switch from horizontal to vertical & vice versa)
- Move to new split : `ctrl+w w`
- Move to the split above : `ctrl+w k`
- Move to the split below : `ctrl+w j`
- Open a buffer number # in a vertical split: `:vert sb#`
- Move current window to a new tab: `ctrl+T`
- Go to definition in new vert split: `ctrl+w v` then `gd`
- Close all buffers but current : `:%bd|e#`
- Close split but leave buffer open : `ctrl+w q`
- Close tab : `:tabclose`

- Show doc of thing under cursor : `shift+k` (repeat to get into the floating window)
- Show diagnostics on floating window : `gl` (repeat to get into the floating window)

- Comment line : `gcc`
- Comment block in Visual Mode : `gc`
- Go to definition : `gd` (opens doc in new buffer)
- Go to references : `gr`
- Go to back to the previous cursor position : `ctrl+o`
- Go to back to the next cursor position : `ctrl+i`

- Display Definition of CXX macro in normal mode : `[d` or `[D`
- Jump to Definition of CXX macro in normal mode : `[ctrl+d` or `[ctrl+D`
- Display Definition of CXX symbol in normal mode : `[i` or `[I` (see :h include)
- Jump to Definition of CXX symbol in normal mode : `[ctrl+i` or `[ctrl+I` (see :h include)

- Start/Stop LSP : `:LspStart` / `:LspStop`
- Toggle diagnostics : `:lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())`
- Toggle inlay hints : `:lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())`
