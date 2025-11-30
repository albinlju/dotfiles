return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "VeryLazy" },
		opts = {
			indent = { enable = true },
			highlight = { enable = true },
			folds = { enable = true },
			ensure_installed = {
				"bash",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"razor",
				"tsx",
				"typescript",
				"scss",
				"vim",
				"yaml",
				"go",
				"vue",
				"css",
				"templ",
				"c_sharp",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		config = function()
			local function map_select(mode, lhs, query)
				vim.keymap.set(mode, lhs, function()
					require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
				end)
			end

			map_select({ "x", "o" }, "if", "@function.inner")
			map_select({ "x", "o" }, "af", "@function.outer")
			map_select({ "x", "o" }, "ic", "@class.inner")
			map_select({ "x", "o" }, "ac", "@class.outer")

            -- stylua: ignore start
            vim.keymap.set("n", "<leader>sa", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end)
            vim.keymap.set("n", "<leader>sf", function() require("nvim-treesitter-textobjects.swap").swap_next("@function.outer") end)
            vim.keymap.set("n", "<leader>sA", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end)
            vim.keymap.set("n", "<leader>sF", function() require("nvim-treesitter-textobjects.swap").swap_previous("@function.outer") end)
			-- stylua: ignore end
		end,
	},
}
