return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        {
          section = "terminal",
          cmd = "ascii-image-converter ~/dotfiles/computer.png -c -C",
          random = 5,
          pane = 2,
          indent = 4,
          height = 30,
        },
      },
    },
  },
}
