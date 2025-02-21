-- For inspiration : https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- Plugin Flags
local enable_tokyonight = true
local enable_lualine = true
local enable_autoclose = true
local enable_gitsigns = true
local enable_comment = true
local enable_illuminate = true -- Highlight occurences under cursor
local enable_guessindent = true
local enable_telescope = true
local enable_nvimtree = true
local enable_treesitter = true
local enable_treesitter_context = true
local enable_bufferline = true
local enable_lsp = false

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<Tab>", ":bn<CR>") -- TAB key to go to next buffer
vim.keymap.set("n", "<S-Tab>", ":bp<CR>") -- Shift - TAB key to go to previous buffer
vim.keymap.set("n", "j", "gj") -- Move down in wrapped line
vim.keymap.set("n", "k", "gk") -- Move up in wrapped line
vim.keymap.set("n", "<leader>l", function() -- Toggle left column, to be able to copy with mouse+shift
    if vim.o.relativenumber or vim.o.number or vim.o.signcolumn == 'yes' then
        vim.o.relativenumber = false
        vim.o.number = false
        vim.o.signcolumn = 'no'
    else
        vim.o.relativenumber = true
        vim.o.number = true
        vim.o.signcolumn = 'yes'
    end

end)

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
vim.o.swapfile = false
vim.o.hlsearch = false
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true
vim.o.shell = "/bin/bash"
vim.g.loaded_netrw = 1 -- Disable netrw file explorer
vim.g.loaded_netrwPlugin = 1

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
        -- Adding opts automatically calls the plugins setup() function
        -- See https://github.com/folke/lazy.nvim doc : opts & config
        opts = {
            options = {
                icons_enabled = true,
                theme = "tokyonight",
                component_separators = "|",
                section_separators = "",

            },
            sections = {
                lualine_c = {
                    {
                        'filename',
                        file_status = true,      -- Displays file status (readonly status, modified status)
                        newfile_status = false,  -- Display new file status (new file means no write after created)
                        path = 3,                -- 0: Just the filename
                        -- 1: Relative path
                        -- 2: Absolute path
                        -- 3: Absolute path, with tilde as the home directory
                        -- 4: Filename and parent dir, with tilde as the home directory
                        shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                        -- for other components. (terrible name, any suggestions?)
                        symbols = {
                            modified = '[+]',      -- Text to show when the file is modified.
                            readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                            unnamed = '[No Name]', -- Text to show for unnamed buffers.
                            newfile = '[New]',     -- Text to show for newly created file before first write
                        }
                    }
                }
            }
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
        "lewis6991/gitsigns.nvim",
        enabled = enable_gitsigns,
        config = function()
            require("gitsigns").setup()
        end
    },
    {
        "numToStr/Comment.nvim",
        enabled = enable_comment,
        opts = {
            -- add any options here
        },
        lazy = false,
        config = function()
            require("Comment").setup()
        end
    },
    {
        "RRethy/vim-illuminate",
        enabled = enable_illuminate,
    },
    {
        "NMAC427/guess-indent.nvim",
        enabled = enable_guessindent,
        config = function()
            require("guess-indent").setup()
        end
    },
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.5",
        enabled = enable_telescope,
        dependencies = { "nvim-lua/plenary.nvim" },
        -- keys = {"<leader>f"}, -- Lazy load the module only once key is pressed
        config = function()
            require("telescope").setup({
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                        },
                    },
                    sorting_strategy = "ascending",
                    wrap_results = true, -- https://github.com/nvim-telescope/telescope.nvim/issues/1958
                }
            })
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        enabled = enable_nvimtree,
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        -- keys = {"<leader>n"}, -- Lazy load the module only once key is pressed
        config = function()
            require("nvim-tree").setup()
            vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeFindFileToggle<cr>")
            -- Hack to Jump to latest used buffer when current buffer is closed
            vim.api.nvim_create_autocmd("BufEnter", {
                nested = true,
                callback = function()
                    local api = require("nvim-tree.api")

                    -- Only 1 window with nvim-tree left: we probably closed a file buffer
                    if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
                        -- Required to let the close event complete. An error is thrown without this.
                        vim.defer_fn(function()
                            -- close nvim-tree: will go to the last hidden buffer used before closing
                            api.tree.toggle({find_file = true, focus = true})
                            -- re-open nivm-tree
                            api.tree.toggle({find_file = true, focus = true})
                            -- nvim-tree is still the active window. Go to the previous window.
                            vim.cmd("wincmd p")
                        end, 0)
                    end
                end
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = enable_treesitter,
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "c", "cpp", "lua", "go", "hcl", "terraform",
                    "javascript", "html", "css", "python", "vimdoc" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                -- incremental_selection = {
                --     enable = true,
                --     keymaps = {
                --         init_selection = "<CR>",
                --         scope_incremental = "<CR>",
                --         node_incremental = "<TAB>",
                --         node_decremental = "<S-TAB>",
                --     },
                -- }
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = enable_treesitter_context,
        opts = {
            max_lines = 3, -- Show only this number of lines
            trim_scope = 'inner',
        },
    },
    {
        "akinsho/bufferline.nvim",
        enabled = enable_bufferline,
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            options = {
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true
                    }
                }
            }
        }

    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        enabled = enable_lsp,
        dependencies = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},             -- Required
            {"williamboman/mason.nvim"},           -- Optional
            {"williamboman/mason-lspconfig.nvim"}, -- Optional
            -- Autocompletion
            {"hrsh7th/nvim-cmp"},     -- Required
            {"hrsh7th/cmp-nvim-lsp"}, -- Required
            {"L3MON4D3/LuaSnip"},     -- Required
        }
    },
})

if enable_lsp then
    local lsp = require("lsp-zero").preset({})
    lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings to learn the available actions
        lsp.default_keymaps({buffer = bufnr})
    end)
    -- (Optional) Configure lua language server for neovim
    -- require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
    lsp.setup()

    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()

    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            ['<CR>'] = cmp.mapping.confirm({select = false}),
            -- Ctrl+Space to trigger completion menu
            ['<C-Space>'] = cmp.mapping.complete(),
            -- Navigate between snippet placeholder
            ['<C-f>'] = cmp_action.luasnip_jump_forward(),
            ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            -- Scroll up and down in the completion documentation
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<Tab>'] = cmp_action.luasnip_supertab(),
            ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        })
    })
    require("mason").setup()
    -- Example : to enable clangd
    -- run : apt install clang, then install clangd from :Mason or :MasonInstall clangd
    require("lspconfig").clangd.setup({})

    -- Download NodeJS & Install typescript-language-server and/or quick-lint-js from :Mason
    -- require("lspconfig").tsserver.setup({})
    -- require("lspconfig").quick_lint_js.setup({})

    -- Install gopls from :MasonInstall gopls
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
    require("lspconfig").gopls.setup({})
    -- Install goimports :MasonInstall goimports
    -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = {only = {"source.organizeImports"}}
            -- buf_request_sync defaults to a 1000ms timeout. Depending on your
            -- machine and codebase, you may want longer. Add an additional
            -- argument after params if you find that you have to write the file
            -- twice for changes to be saved.
            -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                        vim.lsp.util.apply_workspace_edit(r.edit, enc)
                    end
                end
            end
            vim.lsp.buf.format({async = false})
        end
    })

    -- More info https://quick-lint-js.com/blog/show-js-errors-neovim-macos/
    -- Show diagnostic in gutter ?
    vim.diagnostic.config({signs = true})
    -- Show inline errors & warnings
    vim.diagnostic.config({virtual_text = true})
    -- Show error while typing in insert mode ?
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            update_in_insert = false,
        }
    )
end
