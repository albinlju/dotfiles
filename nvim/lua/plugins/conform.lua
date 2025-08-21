return {
  "stevearc/conform.nvim",
  optional = true,
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}

    -- Add eslint_d after prettier for JS/TS/Vue
    for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }) do
      opts.formatters_by_ft[ft] = { "prettier", "eslint_d" }
    end

    -- Add stylelint for styles (after prettier)
    for _, ft in ipairs({ "css", "scss", "less" }) do
      opts.formatters_by_ft[ft] = { "prettier", "stylelint" }
    end

    -- Ensure other filetypes still get prettier if configured by LazyVim
    opts.formatters_by_ft.json = { "prettier" }
    opts.formatters_by_ft.markdown = { "prettier" }
  end,
}
