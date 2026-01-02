-- Setup nvim-cmp.
local cmp = require "cmp"
local luasnip = require("luasnip")

is_tex = function()
    return vim.bo.filetype == "tex"
end

cmp.setup({
    snippet = {
        expand = function(args)
            if vim.bo.filetype == "tex" then
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end
        end,
    },
    window = {
        completion = { border = "rounded" },
        documentation = { border = "rounded" },
    },
    mapping = {
        -- Find a better way to scroll docs.
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),

        -- Expand snippets with spacebar if cmp menu is visible
        ["<Space>"] = cmp.mapping(function(fallback)
            if luasnip.expandable() and cmp.visible() and cmp.get_active_entry() then
                cmp.complete()
                luasnip.expand()
            elseif cmp.visible() and cmp.get_active_entry() then
                cmp.complete()
                cmp.close()
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),
        -- Supertab
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expandable() and is_tex() then
                luasnip.expand()
            elseif luasnip.jumpable() and is_tex() then
                luasnip.jump(1)
            elseif cmp.visible() and not cmp.get_active_entry() then
                cmp.select_next_item({ count = 0 })
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable() and is_tex() then
                luasnip.jump(-1)
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<Return>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<Up>"] = cmp.mapping(function() cmp.select_prev_item() end, { "i", "s" }),
        ["<Down>"] = cmp.mapping(function() cmp.select_next_item() end, { "i", "s" }),
    },

    sources = { { name = "nvim_lsp" }, { name = "path" }, { name = "luasnip" } },
    matching = { disallow_fuzzy_matching = false },
    completion = {
        autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
        },
    },
})
