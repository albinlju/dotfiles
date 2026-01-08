return { -- Autocompletion
  "saghen/blink.cmp",
  event = "VimEnter",
  version = "1.*",
  dependencies = {
    -- Snippet Engine
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
      opts = {},
    },
    "folke/lazydev.nvim",
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = function(_, opts)
    local types = require("blink.cmp.types").CompletionItemKind

    -- 0 = highest priority
    local kind_priority = {
      [types.Variable] = 0,
      [types.Folder] = 1,

      [types.Property] = 1,
      [types.Field] = 1,

      [types.Function] = 2,
      [types.Method] = 2,
      [types.Constructor] = 2,

      [types.Snippet] = 10,
    }

    -- Ensure fuzzy table exists
    opts.fuzzy = opts.fuzzy or {}

    -- Merge fuzzy sorts
    opts.fuzzy.sorts = {
      function(a, b)
        local ka = kind_priority[a.kind] or 99
        local kb = kind_priority[b.kind] or 99

        if ka ~= kb then
          return ka < kb
        end
      end,
      "score",
      "sort_text",
    }

    -- Merge your existing opts defaults (if missing)
    opts.keymap = opts.keymap or { preset = "enter" }
    opts.appearance = opts.appearance or { nerd_font_variant = "mono" }
    opts.completion = opts.completion or { documentation = { auto_show = false, auto_show_delay_ms = 500 } }
    opts.sources = opts.sources
      or {
        default = { "lsp", "path", "snippets", "lazydev" },
        providers = { lazydev = { module = "lazydev.integrations.blink", score_offset = 100 } },
      }
    opts.snippets = opts.snippets or { preset = "luasnip" }
    opts.signature = opts.signature or { enabled = true }
    opts.fuzzy.implementation = opts.fuzzy.implementation or "lua"

    return opts
  end,
}
