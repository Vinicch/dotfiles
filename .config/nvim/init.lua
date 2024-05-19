vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.completeopt = "menuone,noselect,popup,fuzzy"
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.swapfile = false
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.diagnostic.config({ virtual_text = true })
vim.lsp.config("*", { capabilities = vim.lsp.protocol.make_client_capabilities() })

vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist)
vim.keymap.set("n", "grd", vim.lsp.buf.definition)

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function() vim.lsp.buf.format() end
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start()
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.hl.on_yank() end
})

vim.pack.add({
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/folke/snacks.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/folke/lazydev.nvim",
    { src = "https://github.com/catppuccin/nvim",  name = "catppuccin" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.0.0 - 2.0.0") }
})

vim.cmd.colorscheme("catppuccin")

require("lualine").setup({})
require("blink.cmp").setup()

require("oil").setup()
vim.keymap.set("n", "<leader>e", require("oil").toggle_float)

require("snacks").setup({ bigfile = {}, picker = {} })
vim.keymap.set("n", "<leader>fd", Snacks.picker.files)
vim.keymap.set("n", "<leader>fb", Snacks.picker.buffers)
vim.keymap.set("n", "<leader>fg", Snacks.picker.grep)
vim.keymap.set("n", "<leader>fh", Snacks.picker.help)
vim.keymap.set("n", "<leader>fl", Snacks.picker.lines)
vim.keymap.set("n", "<leader>fu", Snacks.picker.undo)
vim.keymap.set("n", "<leader>fr", Snacks.picker.resume)
vim.keymap.set({ "n", "v" }, "<leader>fw", Snacks.picker.grep_word)

require("nvim-treesitter").install({
    "bash", "css", "dockerfile", "go",
    "gomod", "html", "javascript", "json",
    "python", "regex", "rust", "sql",
    "terraform", "toml", "typescript", "yaml"
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "cssls", "gopls", "html",
        "lua_ls", "rust_analyzer", "ts_ls" }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function() require("lazydev").setup() end
})
