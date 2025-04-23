return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
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
        html = {},
        stylelint_lsp = {},
      },
    },
  },
}
