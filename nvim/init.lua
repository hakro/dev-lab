vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate" -- :MasonUpdate updates registry contents
    },
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
})


require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer" },
}
require'lspconfig'.pyright.setup{}
