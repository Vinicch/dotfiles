local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "tpope/vim-sleuth",
    "tpope/vim-fugitive",
    "stevearc/dressing.nvim",

    { "nvim-lualine/lualine.nvim", opts = {} },
    { "numToStr/Comment.nvim",     opts = {} },

    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd.colorscheme("tokyonight-moon")
        end
    },

    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "<leader>e", require("oil").toggle_float)
        end
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>fs", builtin.find_files)
            vim.keymap.set("n", "<leader>fg", builtin.live_grep)
            vim.keymap.set("n", "<leader>fb", builtin.buffers)
            vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags)
        end
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash", "c", "css", "dockerfile", "go", "gomod",
                    "html", "javascript", "json", "lua", "markdown",
                    "python", "rust", "sql", "terraform", "toml",
                    "typescript", "vimdoc", "vim", "yaml"
                },
                highlight = { enable = true },
            })
        end
    },

    require("plugins.lsp"),
    require("plugins.cmp"),
})
