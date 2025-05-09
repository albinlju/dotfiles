return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    dependencies = {
      {
        -- the handlers for Roslyn.
        "tris203/rzls.nvim",
        config = function()
          require("rzls").setup({
            path = "rzls",
            on_attach = require("helpers.lspattach"),
            capabilities = require("helpers.lspcapabilities"),
          })
        end,
      },
    },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    config = function()
      ---@type string[]
      local cmd = {}
      local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")

      vim.list_extend(cmd, {
        "roslyn",
        "--stdio",
        "--logLevel=Information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
        "--razorDesignTimePath=" .. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
      })

      require("roslyn").setup({
        config = {
          cmd = cmd,
          handlers = require("rzls.roslyn_handlers"),
          settings = {
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,

              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_indexer_parameters = true,
              dotnet_enable_inlay_hints_for_literal_parameters = true,
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              dotnet_enable_inlay_hints_for_other_parameters = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = true,
            },
          },
        },
      })
    end,
    init = function()
      -- We add the Razor file types before the plugin loads.
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })
    end,
  },
}
