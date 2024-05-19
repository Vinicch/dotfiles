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

vim.pack.add({
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/folke/snacks.nvim',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/folke/lazydev.nvim',
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
    { src = 'https://github.com/saghen/blink.cmp',                version = vim.version.range('1.0') }
})

-- Theme
vim.cmd.colorscheme("tokyonight-moon")

require("lualine").setup({})
require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash", "c", "css", "dockerfile", "go", "gomod",
        "html", "javascript", "json", "lua", "markdown",
        "python", "rust", "sql", "terraform", "toml",
        "typescript", "vimdoc", "vim", "yaml"
    },
    highlight = { enable = true }
}

-- Picker and explorer
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

require("oil").setup()
vim.keymap.set("n", "<leader>e", require("oil").toggle_float)

-- Completion and LSP
require("blink.cmp").setup()
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "cssls", "gopls", "html",
        "lua_ls", "rust_analyzer", "ts_ls" }
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        require("lazydev").setup({
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } }
            }
        })
    end
})
