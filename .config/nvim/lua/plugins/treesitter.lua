return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash", "c", "css", "dockerfile", "go",
                "html", "javascript", "json", "lua", "markdown",
                "python", "rust", "sql", "terraform", "toml",
                "typescript", "vimdoc", "vim", "yaml"
            },
            highlight = { enable = true },
        })
    end
}
