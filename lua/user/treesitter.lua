local success, treesitter = pcall(require, "nvim-treesitter.configs")
if not success then
    print("WARNING: treesitter not loaded.")
    return
end

treesitter.setup({
    ensure_installed = { "python", "bash", "rust", "lua" },
    sync_install = false,
    highlight = { enable = true, disable = { "tex", "latex" } }, -- use vimtex
    indent = { enable = true, },
    folding = { enable = true },
})

require 'treesitter-context'.setup {
    enable = true,         -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 7,         -- How many lines the window should span. Values <= 0 mean no limit.
    multiline_threshold = 3, -- Maximum number of lines to show for a single context
    separator = '⎯',
}

vim.treesitter.language.register("bash", "shell")
vim.treesitter.language.register("go", "golang")
