require('telescope').setup {
    defaults = {
        file_ignore_patterns = { ".git/.*$", },
    },
}
-- require("telescope").load_extension("file_browser")

local keymap = vim.api.nvim_set_keymap
local term_opts = { silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- keymap("n", "<leader>ff", ":Telescope live_grep hidden=true<CR>", term_opts)
-- keymap("n", "<leader>fp", ":Telescope find_files hidden=true<CR>",
--     term_opts)
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", term_opts)
-- keymap("n", "<leader>fr", ":Telescope resume<CR>", term_opts)
--
-- -- git-related
-- keymap("n", "<leader>fb", ":Telescope git_branches<CR>", term_opts)
-- keymap("n", "<leader>fc", ":Telescope git_commits<CR>", term_opts)
-- keymap("n", "<leader>fs", ":Telescope git_status<CR>", term_opts)
