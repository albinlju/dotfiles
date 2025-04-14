return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "scss",
        "vim",
        "yaml",
        "go",
        "vue",
        "css",
        "templ",
        "c_sharp",
      },
    },
    config = function()
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
