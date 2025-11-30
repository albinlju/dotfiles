return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      contrast = "hard",
    })
    vim.cmd.colorscheme("gruvbox")
  end,
}
