-- For inspiration : https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- Plugin Flags
local enable_tokyonight = false
local enable_lualine = false
local enable_autoclose = true
local enable_gitsigns = true
local enable_illuminate = true -- Highlight occurences under cursor
local enable_guessindent = true
local enable_telescope = true
local enable_nvimtree = false
local enable_treesitter = false
local enable_treesitter_context = false
local enable_bufferline = false
local enable_lsp = false

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<Tab>", ":bn<CR>") -- TAB key to go to next buffer
vim.keymap.set("n", "<S-Tab>", ":bp<CR>") -- Shift - TAB key to go to previous buffer
vim.keymap.set("n", "j", "gj") -- Move down in wrapped line
vim.keymap.set("n", "k", "gk") -- Move up in wrapped line
vim.keymap.set("n", "'", "`") -- Jump to exact position when using marks, instead of beginning of line
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
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

vim.cmd.colorscheme("retrobox")
vim.o.background = "dark"
vim.o.winborder = "rounded" --For retrobox / tokyonight
-- vim.o.winborder = "none"
vim.o.signcolumn = "yes"

vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
-- vim.o.winborder = "rounded"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 7 -- Keep lines below and above the cursor
vim.o.swapfile = false
vim.o.hlsearch = false
vim.o.updatetime = 300 -- Decrease update time
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true
vim.o.shell = "/bin/bash"

-- vim.o.path = "**"
vim.o.wildignore = "**/bin/*,*.o,*.a,*.obj,*.d,*.data,__pycache__/*,.git/*,node_modules/*,**/thirdparty/*,tests/*,**/unvendored/*,**/*.moc.cpp"

-- vim.g.loaded_netrw = 1 -- Disable netrw file explorer if using NvimTree
-- vim.g.loaded_netrwPlugin = 1
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = '.DS_Store,*/tmp/*,.*\\.so,.*\\.a,.*\\.o,*.swp,*.zip,*.git'
-- vim.g.netrw_list_hide = '.DS_Store,*/tmp/*,*.so,*.a,*.o,*.swp,*.zip,*.git'
-- vim.g.netrw_winsize = 75
-- Sort so that dirs are first, and .h and .c(pp) files are actually next to each other
-- Double square brackets [[ ]] are used to avoid escaping.
vim.g.netrw_sort_sequence = [[[\/]$]]
vim.g.netrw_sort_by = 'name'

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
			vim.keymap.set("n", "<leader>gn", "<cmd>Gitsigns next_hunk<CR>")
			vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>")
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
                    file_ignore_patterns = {
                        "node_modules/",
                        "thirdparty/",
                        ".git/"
                    },
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
        "neovim/nvim-lspconfig",
        enabled = enable_lsp,
    },
})

if enable_lsp then
    vim.lsp.config['clangd'] = {
        cmd = {'clangd', '--background-index'}, -- should be good for speed
    }
    -- Enable it here
    --vim.lsp.enable('clangd')

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float) -- Instead of of <C-w>d
    vim.keymap.set('i', '<C-Space>', function()
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
