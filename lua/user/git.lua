require('gitsigns').setup(
    {
        numhl = true,
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            -- Actions
            map('n', '<space>hs', gs.stage_hunk)
            map('n', '<space>hr', gs.reset_hunk)
            map('v', '<space>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
            map('v', '<space>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
            map('n', '<space>hS', gs.stage_buffer)
            map('n', '<space>hu', gs.undo_stage_hunk)
            map('n', '<space>hR', gs.reset_buffer)
            map('n', '<space>hp', gs.preview_hunk)
            map('n', '<space>hb', function() gs.blame_line { full = true } end)
            map('n', '<space>tb', gs.toggle_current_line_blame)
            map('n', '<space>hd', gs.diffthis)
            map('n', '<space>hD', function() gs.diffthis('~') end)
            map('n', '<space>td', gs.toggle_deleted)

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
)

require"gitlinker".setup({
  opts = {
    remote = "up", -- force the use of a specific remote
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = true,
    -- callback for what to do with the url
    action_callback = require"gitlinker.actions".copy_to_clipboard,
    -- print the url after performing the action
    print_url = true,
  },
  callbacks = {
        ["github.com"] = require"gitlinker.hosts".get_github_type_url,
        ["gitlab.com"] = require"gitlinker.hosts".get_gitlab_type_url,
  },
-- default mapping to call url generation with action_callback
  mappings = "<leader>gl"
})
