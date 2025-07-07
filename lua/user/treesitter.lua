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

require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 7, -- How many lines the window should span. Values <= 0 mean no limit.
  multiline_threshold = 2, -- Maximum number of lines to show for a single context
}
-- require'treesitter-context'.setup{
--   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
--   max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--   line_numbers = true,
--   multiline_threshold = 20, -- Maximum number of lines to show for a single context
--   trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--   mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
--   -- Separator between context and content. Should be a single character string, like '-'.
--   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--   separator = nil,
--   zindex = 20, -- The Z-index of the context window
--   on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- }

vim.treesitter.language.register("bash", "shell")
vim.treesitter.language.register("go", "golang")

