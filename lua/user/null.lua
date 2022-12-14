local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local lsp_formatting = function(bufnr)
    vim.lsp.buf.formatting({
        filter = function(client) return client.name == "null-ls" end,
        bufnr = bufnr,
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local FORMATTING = methods.internal.FORMATTING
local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING

-- local lua_format = helpers.make_builtin({
--     name = "lua_format",
--     meta = {
--         url = "https://github.com/Koihik/LuaFormatter",
--         description = "Reformats your Lua source code.",
--     },
--     method = FORMATTING,
--     filetypes = { "lua" },
--     generator_opts = {
--         command = "lua-format",
--         args = {
--             "-i",
--             "--indent-width=2",
--             "--single-quote-to-double-quote",
--             "--chop-down-parameter",
--             "--chop-down-table",
--             "--extra-sep-at-table-end",
--             "--chop-down-parameter",
--             "--spaces-inside-table-braces",
--         },
--         to_stdin = true,
--     },
--     factory = helpers.formatter_factory,
-- })
--
-- local clang_format = helpers.make_builtin({
--     name = "clang_format",
--     meta = {
--         url = "https://www.kernel.org/doc/html/latest/process/clang-format.html",
--         description = "Tool to format C/C++/… code according to a set of rules and heuristics.",
--     },
--     method = { FORMATTING, RANGE_FORMATTING },
--     filetypes = { "c", "cpp", "cs", "java", "cuda", "h" },
--     generator_opts = {
--         command = "clang-format",
--         args = helpers.range_formatting_args_factory({
--             "-assume-filename",
--             "$FILENAME",
--         }, "--offset", "--length", { use_length = true }),
--         to_stdin = true,
--     },
--     factory = helpers.formatter_factory,
-- })
--
-- local latexindent = helpers.make_builtin({
--     name = "latexindent",
--     meta = {
--     },
--     method = { FORMATTING },
--     filetypes = { "tex" },
--     generator_opts = {
--         command = "latexindent",
--         args = helpers.range_formatting_args_factory({
--             "$FILENAME",
--         }, [[-y="defaultIndent: '    '"]]),
--         to_stdin = true,
--     },
--     factory = helpers.formatter_factory,
-- })
--

local latexindent = helpers.make_builtin({
    name = "latexindent",
    meta = {
        url = "https://github.com/cmhughes/latexindent.pl",
        description = "A perl script for formatting LaTeX files that is generally included in major TeX distributions.",
    },
    method = FORMATTING,
    filetypes = { "tex" },
    generator_opts = { command = "latexindent", args = { "-l" }, to_stdin = true },
    factory = helpers.formatter_factory,
})

null_ls.setup({ sources = { } })
