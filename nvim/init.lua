-- For inspiration : https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

vim.g.mapleader = " "

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
vim.o.scrolloff = 10 -- Keep lines below and above the cursor
vim.o.noswapfile = true
vim.o.hlsearch = false
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true
vim.o.shell = "/bin/bash"
vim.g.loaded_netrw = 1 -- Disable netrw file explorer
vim.g.loaded_netrwPlugin = 1

-- Plugin Flags
local enable_tokyonight = true
local enable_lualine = true
local enable_autoclose = true
local enable_nvimtree = true
local enable_bufferline = true
local enable_mason = true

-- Remove trailing empty spaces:
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Plugin configs
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/tokyonight.nvim",
        enabled = enable_tokyonight,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "tokyonight-night"
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        enabled = enable_lualine,
        opts = {
            options = {
                icons_enabled = true,
                theme = "tokyonight",
                component_separators = "|",
                section_separators = "",
            },
        },
    },
    {
        "m4xshen/autoclose.nvim",
        enabled = enable_autoclose,
        config = function()
            require("autoclose").setup()
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        enabled = enable_nvimtree,
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-tree").setup()
            vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")
        end
    },
    {
        "akinsho/bufferline.nvim",
        enabled = enable_bufferline,
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup()
        end
    },
    {
        "williamboman/mason.nvim",
        enabled = enable_mason,
        build = ":MasonUpdate",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
})
