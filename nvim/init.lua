-- For inspiration : https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- Plugin Flags
local enable_autoclose = true
local enable_gitsigns = true
local enable_guessindent = true
local enable_illuminate = true
local enable_treesitter_context = false
local enable_lsp = false

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<C-p>", "<C-^>") -- Switch to alternate file (^ is not detected in AZERTY)
vim.keymap.set("n", "<Tab>", ":bn<CR>") -- TAB key to go to next buffer
vim.keymap.set("n", "<S-Tab>", ":bp<CR>") -- Shift - TAB key to go to previous buffer
vim.keymap.set("n", "j", "gj") -- Move down in wrapped line
vim.keymap.set("n", "k", "gk") -- Move up in wrapped line
vim.keymap.set("n", "'", "`") -- Jump to exact position when using marks, instead of beginning of line
vim.keymap.set("n", "<Esc>", ":noh<CR>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("n", "<leader>e", ":e **/*") -- Search file recusively
vim.keymap.set("n", "<leader>w", function() -- Toggle line wrapping
    vim.o.wrap = not vim.o.wrap
end)
vim.keymap.set("n", "<leader>l", function() -- Toggle left column, to be able to copy with mouse+shift
    if vim.o.relativenumber or vim.o.number or vim.o.signcolumn == "yes" then
        vim.o.relativenumber = false
        vim.o.number = false
        vim.o.signcolumn = "no"
    else
        vim.o.relativenumber = true
        vim.o.number = true
        vim.o.signcolumn = "yes"
    end

end)

vim.cmd.colorscheme("retrobox")
vim.o.background = "dark"
vim.o.winborder = "rounded" --For retrobox / tokyonight
vim.o.signcolumn = "yes"

vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.jumpoptions = "view" -- Keep location of cursor when jumping between buffers
vim.o.scrolloff = 7 -- Keep lines below and above the cursor
vim.o.swapfile = false
vim.o.hlsearch = false
vim.o.updatetime = 300 -- Decrease update time
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true
vim.o.shell = "/bin/bash"
vim.o.completeopt = "menu,popup,noselect"
-- vim.o.path = "**"
vim.o.wildignore = "**/bin/*,*.so,*.o,*.a,*.obj,*.d,*.data,*.pyc,__pycache__/*,.git/*,node_modules/*,**/thirdparty/*,**/unvendored/*,**/*.moc.cpp,*.dat"

-- Exclude .git directory
vim.o.grepprg = "grep -HIn --exclude-dir=.git $* /dev/null"

-- Sort so that dirs are first, and .h and .c(pp) files are actually next to each other
-- Double square brackets [[ ]] are used to avoid escaping.
vim.g.netrw_sort_sequence = [[[\/]$]]
vim.g.netrw_sort_by = "name"
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = ".DS_Store,*/tmp/*,.*\\.so,.*\\.a,.*\\.o,*.swp,*.zip,*.git"

-- Remove trailing empty spaces:
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- Start term in split and in insert mode, like vim
vim.cmd([[
    cabbrev term split\|terminal
]])
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert",
})

-- Plugin configs
vim.pack.add({
    'https://github.com/m4xshen/autoclose.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/NMAC427/guess-indent.nvim',
    'https://github.com/RRethy/vim-illuminate',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
})

if enable_autoclose then
    require("autoclose").setup()
end
if enable_gitsigns then
    require("gitsigns").setup()
    vim.keymap.set("n", "<leader>gn", "<cmd>Gitsigns next_hunk<CR>")
    vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>")
end
if enable_illuminate then
    require("illuminate")
end
if enable_guessindent then
    require("guess-indent").setup()
end
if enable_treesitter_context then
    require("guess-indent").setup()
end

if enable_lsp then
    vim.lsp.config["clangd"] = {
        cmd = {"clangd", "--background-index"}, -- should be good for speed
    }
    -- Enable it here
    -- vim.lsp.enable("clangd")
    -- vim.keymap.set("n", "<leader>f", ":grep -r --include=*{.cpp,.h} --exclude=*.moc.cpp \"\" .<left><left><left>") -- Global recursive grep

    vim.keymap.set("n", "gd", vim.lsp.buf.definition)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float) -- Instead of of <C-w>d
    -- Switch from/to .h and .cxx files (comes from plugin neovim/nvim-lspconfig)
    vim.keymap.set("n", "<C-h>", vim.cmd.LspClangdSwitchSourceHeader)
    vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get()
    end)

    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist)  -- Get Global Diagnostics in QFixList
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist) -- Get local buffer Diagnostics in LocList

    vim.diagnostic.config({
        signs = true,             -- Toggle diagnostic in gutter
        virtual_text = false,     -- Toggle inline errors & warnings
        update_in_insert = false, -- Show error while typing in insert mode
    })

    -- Toggle inlays (hints of function paramters)
    vim.lsp.inlay_hint.enable(false)
end
