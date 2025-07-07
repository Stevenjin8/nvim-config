local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local opts = { noremap = true, silent = true }



local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable()
    end
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', "<space>i", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set({ 'i', 'n' }, '<space>fs', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>fm', function() vim.lsp.buf.format { async = false, timeout_ms = 1000 } end, bufopts)
    vim.keymap.set('n', '<space>de', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>dq', vim.diagnostic.setloclist, opts)
end

lspconfig.texlab.setup {
    on_attach = on_attach,
    root_dir = util.root_pattern('.git', '.latexmkrc', ".texlabroot", "texlabroot", "Tectonic.toml"),
}

lspconfig.helm_ls.setup {
    settings = {
        ['helm-ls'] = {
            yamlls = {
                path = "yaml-language-server",
            }
        }
    }
}

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = { globals = { "vim" } },
            completion = {
                -- Disable autocompletion with comments. I can spell well enough.
                showWord = "Disable",
                workspaceWord = "Disable",
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

lspconfig.pyright.setup({
    on_attach = on_attach,
    settings = {
        python = {
            analysis = { typeCheckingMode = "none" },
            diagnosticMode = "openFilesOnly",
            autoSerachPaths = true,
        },
    },
})

lspconfig.clangd.setup({
    -- cmd = {"/home/sj/source/clangd_18.1.3/bin/clangd"},
    on_attach = on_attach,
    settings = { CompileFlags = { std = "cpp14", compiler = "clang" } },
    filetypes = { "h", "hpp", "cpp", "cc", "c" }
})

lspconfig.gopls.setup {
    on_attach = on_attach,
}

lspconfig.bashls.setup {
    on_attach = on_attach,
}

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                allFeatures = true,
                buildScripts = {
                    enable = true,
                    rebuildOnSave = false,
                },
            },
            procMacro = {
                enable = true
            },
            inlayHints = {
                enable = true,
                typeHints = true,
                parameterHints = true,
                chainingHints = true,
                maxLength = 40,
            },
            checkOnSave = {
                allTargets = true,
                command = "clippy",
            },
        }
    }
})
