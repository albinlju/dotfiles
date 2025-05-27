return {
  "williamboman/mason.nvim",
  branch = "v1.x",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    branch = "v1.x",
  },
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
      "stylelint",
    },
  },
}
