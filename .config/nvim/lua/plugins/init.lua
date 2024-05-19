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
    require("plugins.telescope"),
    require("plugins.lsp"),
    require("plugins.treesitter"),
    require("plugins.cmp"),

    "tpope/vim-fugitive",
    "stevearc/dressing.nvim",

    { "nvim-lualine/lualine.nvim", opts = {} },
    { "numToStr/Comment.nvim",     opts = {} },

    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd.colorscheme("tokyonight")
        end
    },

    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "<leader>e", require("oil").toggle_float)
        end
    },
})
