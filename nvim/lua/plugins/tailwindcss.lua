return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes = { "templ", "html", "jsx", "tsx", "javascript", "typescript" },
          settings = {
            tailwindCSS = {
              includeLanguages = {
                templ = "html",
              },
            },
          },
        },
      },
    },
  },
}
