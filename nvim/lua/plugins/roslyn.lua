return {
  {
    "seblj/roslyn.nvim",
    enabled = true,
    ft = "cs",
    opts = {},
    dependencies = {
      { "williamboman/mason.nvim", confg = true, cmd = "Mason", dependencies = { "roslyn.nvim" } },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },
        vtsls = {},
        marksman = {},
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "markdownlint-cli2", "markdown-toc" },
    },
  },
}
