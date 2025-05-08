return {
  "williamboman/mason.nvim",
  branch = "v1.x",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    branch = "v1.x",
  },
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
      "stylelint",
    },
  },
}
