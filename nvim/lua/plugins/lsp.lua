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
        eslint = {},
      },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = true
            end
          end)
        end,
      },
    },
    {
      "neovim/nvim-lspconfig",
      opts = function(_, opts)
        if opts.servers.vtsls then
          table.insert(opts.servers.vtsls.filetypes, "vue")
          LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
            {
              name = "@vue/typescript-plugin",
              location = LazyVim.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
              languages = { "vue" },
              configNamespace = "typescript",
              enableForWorkspaceTypeScriptVersions = true,
              settings = {
                typescript = {
                  inlayHints = {
                    parameterNames = { enabled = "none" },
                    parameterTypes = { enabled = false },
                    variableTypes = { enabled = false },
                    propertyDeclarationTypes = { enabled = false },
                    functionLikeReturnTypes = { enabled = false },
                    enumMemberValues = { enabled = false },
                  },
                },
              },
            },
          })
        end
      end,
    },
  },
}
