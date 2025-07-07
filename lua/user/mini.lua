require('mini.comment').setup()
require('mini.move').setup()
require('mini.surround').setup(
    {
        mappings = {
            add = '<Leader>sa',            -- Add surrounding in Normal and Visual modes
            delete = '<Leader>sd',         -- Delete surrounding
            highlight = '<Leader>sh',      -- Highlight surrounding
            replace = '<Leader>sr',        -- Replace surrounding
            update_n_lines = '<Leader>sn', -- Update `n_lines`

            suffix_last = 'l',     -- Suffix to search with "prev" method
            suffix_next = 'n',     -- Suffix to search with "next" method
        },
        custom_surroundings = {
            ['d'] = { input = { { '%b()', '%b[]', '%b{}', '%b<>', '%b\'\'', '%b\"\"', '%b``' }, '^.().*().$', }, output = { left = '(', right = ')' } },
            ['B'] = { input = { '%b{}', '^.%s*().-()%s*.$' }, output = { left = '{ ', right = ' }' } },
        },


    }

)
require('mini.tabline').setup({})
