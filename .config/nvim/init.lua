--- @diagnostic disable: missing-fields

vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.completeopt = "menuone,noselect,popup,fuzzy"
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.diagnostic.config({ virtual_text = true })
vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.lsp.config("*", { capabilities = vim.lsp.protocol.make_client_capabilities() })

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function() vim.lsp.buf.format() end
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.hl.on_yank() end
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "tpope/vim-fugitive",
    "neovim/nvim-lspconfig",
    { "nvim-lualine/lualine.nvim", opts = {} },
    { "saghen/blink.cmp",          opts = {}, version = "1.*" },
    {
        "folke/tokyonight.nvim",
        config = function() vim.cmd.colorscheme("tokyonight-moon") end
    },
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "<leader>e", require("oil").toggle_float)
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        branch = "master",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "bash", "c", "css", "dockerfile", "go", "gomod",
                    "html", "javascript", "json", "lua", "markdown",
                    "python", "rust", "sql", "terraform", "toml",
                    "typescript", "vimdoc", "vim", "yaml"
                },
                highlight = { enable = true }
            }
        end
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        config = function()
            require("snacks").setup { bigfile = {}, picker = {} }
            vim.keymap.set("n", "<leader>fd", Snacks.picker.files)
            vim.keymap.set("n", "<leader>fb", Snacks.picker.buffers)
            vim.keymap.set("n", "<leader>fl", Snacks.picker.lines)
            vim.keymap.set("n", "<leader>fg", Snacks.picker.grep)
            vim.keymap.set("n", "<leader>fw", Snacks.picker.grep_word)
            vim.keymap.set("v", "<leader>fw", Snacks.picker.grep_word)
            vim.keymap.set("n", "<leader>fh", Snacks.picker.help)
            vim.keymap.set("n", "<leader>fu", Snacks.picker.undo)
            vim.keymap.set("n", "<leader>fr", Snacks.picker.resume)
        end
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } }
            }
        }
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = { "clangd", "cssls", "gopls", "html",
                    "lua_ls", "rust_analyzer", "ts_ls" }
            }
        end
    }
}, {})
