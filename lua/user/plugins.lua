-- bootstrap lazy
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
    -- { "folke/neodev.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",               -- Useful lua functions d ny lots of plugins

    "hrsh7th/nvim-cmp",                    -- The completion plugin
    "hrsh7th/cmp-nvim-lsp",                -- The completion plugin
    "hrsh7th/cmp-path",                    -- path completions
    "hrsh7th/cmp-nvim-lsp-signature-help", -- lua completions
    -- "hrsh7th/cmp-buffer",                  -- buffer completions
    -- "hrsh7th/cmp-cmdline",                 -- cmdline completions

    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-file-browser.nvim",

    -- Snippets
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    "farmergreg/vim-lastplace",

    "nvim-treesitter/nvim-treesitter",
    "nvim-lualine/lualine.nvim",
    "jose-elias-alvarez/null-ls.nvim",

    "sindrets/diffview.nvim",
    "lewis6991/gitsigns.nvim",
    "towolf/vim-helm",
    "nvim-treesitter/nvim-treesitter-context",
    -- "iamcco/markdown-preview.nvim",
    -- 'akinsho/bufferline.nvim',
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "v3.11.0",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        build = "make tiktoken",          -- Only on MacOS or Linux
        opts = {
            debug = false,                 -- Enable debugging
            -- See Configuration section for rest
        },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 10,
                    keymap = {
                        accept = "<M-l>",
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<M-e>"
                    },
                },
                panel = { enabled = false },
                filetypes = {
                    markdown = true,
                    yaml = true,
                    lua = true,
                    python = true,
                    ["."] = false,             -- disable for all unlisted filetypes
                },
                copilot_node_command = 'node', -- Node.js version path
            })
        end
    },
    { 'echasnovski/mini.nvim', version = '*' },

}

require("lazy").setup(plugins, {})
