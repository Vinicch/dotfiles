return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "j-hui/fidget.nvim",
    },
    config = function()
        require("fidget").setup({})
        require("neodev").setup()
        require("mason").setup()

        local servers = {
            clangd = {},
            cssls = {},
            gopls = {
                gopls = {
                    analyses = { unusedparams = true, unusedwrite = true },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
            html = {},
            lua_ls = {
                Lua = {
                    diagnostics = {
                        disable = { "missing-fields" },
                        globals = { "vim" }
                    }
                },
            },
            rust_analyzer = {},
            terraformls = {},
            ts_ls = {}
        }

        local augroup = vim.api.nvim_create_augroup("LSPFormat", {})
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(name)
                    require("lspconfig")[name].setup {
                        settings = servers[name],
                        capabilities = require("blink.cmp").get_lsp_capabilities(),
                        on_attach = function()
                            vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
                            vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)

                            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
                            vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = 0 })
                            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
                            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = 0 })

                            local builtin = require("telescope.builtin")
                            vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
                            vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
                            vim.keymap.set("n", "gi", builtin.lsp_implementations, { buffer = 0 })
                            vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { buffer = 0 })
                            vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { buffer = 0 })

                            vim.api.nvim_clear_autocmds({ event = "BufWritePre", buffer = 0, group = augroup })
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                group = augroup,
                                buffer = 0,
                                callback = function() vim.lsp.buf.format() end,
                            })
                        end,
                    }
                end
            },
        })
    end
}
