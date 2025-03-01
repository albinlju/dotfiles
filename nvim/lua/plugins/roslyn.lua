return {
  {
    "seblj/roslyn.nvim",
    enabled = true,
    ft = "cs",
    opts = {},
  },

  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", confg = true, cmd = "Mason", dependencies = { "roslyn.nvim" } },
  },
}
