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
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local plugins = {
    -- { "folke/neodev.nvim", opts = {} },
    -- tex
    "L3MON4D3/LuaSnip",
    "lervag/vimtex",
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",               -- Useful lua functions d ny lots of plugins

    "hrsh7th/nvim-cmp",                    -- The completion plugin
    "hrsh7th/cmp-nvim-lsp",                -- The completion plugin
    "hrsh7th/cmp-path",                    -- path completions
    "hrsh7th/cmp-nvim-lsp-signature-help", -- lua completions

    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "farmergreg/vim-lastplace",
    "ruifm/gitlinker.nvim",

    "nvim-treesitter/nvim-treesitter",
    "nvim-lualine/lualine.nvim",

    "sindrets/diffview.nvim",
    "lewis6991/gitsigns.nvim",
    "towolf/vim-helm",
    "nvim-treesitter/nvim-treesitter-context",
    'MeanderingProgrammer/render-markdown.nvim',
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },
    { 'echasnovski/mini.nvim', version = '*' },
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({
    --             suggestion = {
    --                 enabled = true,
    --                 auto_trigger = true,
    --                 debounce = 10,
    --                 keymap = {
    --                     accept = "<M-l>",
    --                     next = "<M-]>",
    --                     prev = "<M-[>",
    --                     dismiss = "<M-e>"
    --                 },
    --             },
    --             panel = { enabled = false },
    --             filetypes = {
    --                 markdown = true,
    --                 yaml = true,
    --                 lua = true,
    --                 python = true,
    --                 ["."] = false,             -- disable for all unlisted filetypes
    --             },
    --             copilot_node_command = 'node', -- Node.js version path
    --         })
    --     end
    -- },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.nvim'
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
    {
        "folke/snacks.nvim",
        priority = 2000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- bigfile = { enabled = true },
            -- dashboard = { enabled = true },
            words = { enabled = false },
            explorer = { enabled = true },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 1000,
            },
            picker = { enabled = true },
            -- quickfile = { enabled = true },
            -- scroll = { enabled = true },
            statuscolumn = { enabled = true },
            styles = {
                notification = {
                    -- wo = { wrap = true } -- Wrap notifications
                }
            }
        },
        keys = {
            -- Top Pickers & Explorer
            -- { "<space><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
            { "<space>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
            { "<space>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
            { "<space>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
            { "<space>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
            { "<space>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
            -- find
            { "<space>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
            { "<space>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<space>fp",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
            { "<space>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
            -- { "<space>ff",      function() Snacks.picker.projects() end,                                desc = "Projects" },
            { "<space>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
            -- git
            { "<space>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
            { "<space>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
            { "<space>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
            { "<space>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
            { "<space>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
            { "<space>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
            { "<space>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
            -- Grep { "<space>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
            { "<space>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
            { "<leader>sg",     function() Snacks.picker.grep() end,                                    desc = "Grep" },
            { "<space>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
            -- search
            { '<space>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
            { '<space>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
            { "<leader>sa",     function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
            { "<space>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
            { "<space>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
            { "<space>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
            { "<space>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
            { "<space>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
            { "<space>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
            { "<space>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
            { "<space>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
            { "<space>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
            { "<space>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
            { "<space>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
            { "<space>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
            { "<space>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
            { "<space>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
            { "<space>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
            { "<space><space>", function() Snacks.picker.resume() end,                                  desc = "Resume" },
            { "<space>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
            { "<space>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
            -- LSP
            { "gd",             function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
            { "gD",             function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
            { "gr",             function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
            { "gI",             function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
            { "gy",             function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
            { "<space>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
            { "<space>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
            -- Other
            { "<space>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
            { "<space>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
            { "<space>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
            { "<space>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
            { "<space>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
            { "<space>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
            { "<space>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
            { "<space>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
            { "<space>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
            { "<space>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
            { "<c-/>",          function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
            { "<c-_>",          function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
            { "]]",             function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
            { "[[",             function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
            {
                -- Enable snack word highlights
                "<space>sE",
                function() Snacks.words.enable() end,
                desc = "Snack: Enable word highlights",
                mode = "n",
            },
            {

                -- Disable snack word highlights
                "<space>sX",
                function() Snacks.words.disable() end,
                desc = "Snack: Disable word highlights",
                mode = "n",
            }

        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    -- Create some toggle mappings
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle.option("conceallevel",
                        { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                        "<leader>ub")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                    Snacks.toggle.indent():map("<leader>ug")
                    Snacks.toggle.dim():map("<leader>uD")
                end,
            })
        end,
    },
    {
        "folke/sidekick.nvim",
        opts = {
            -- add any options here
            -- cli = {
            --     mux = {
            --         backend = "zellij",
            --         enabled = true,
            --     },
            -- },
        },
        keys = {
            {
                "<m-l>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<m-l>" -- fallback to normal tab
                    end
                end,
                expr = true,
            },
                desc = "Goto/Apply Next Edit Suggestion",
            {
                "<c-.>",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle",
                mode = { "n", "t", "i", "x" },
            },
            {
                "<leader>aa",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").select() end,
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
                desc = "Select CLI",
            },
            {
                "<leader>ad",
                function() require("sidekick.cli").close() end,
                desc = "Detach a CLI Session",
            },
            {
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function() require("sidekick.cli").send({ msg = "{file}" }) end,
                desc = "Send File",
            },
            {
                "<leader>av",
                function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
            -- Example of a keybinding to open Claude directly
            {
                "<leader>ac",
                function() require("sidekick.cli").toggle({ name = "copilot", focus = true }) end,
                desc = "Sidekick Toggle Claude",
            },
        },
    },
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    }
}

require("lazy").setup(plugins, {})
