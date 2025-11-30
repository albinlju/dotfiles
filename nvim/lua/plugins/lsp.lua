return {
	"mason-org/mason-lspconfig.nvim",
	event = "BufReadPost",
	opts = {
		ensure_installed = {
			"stylua",
			"vue_ls",
			"vtsls",
			"ts_ls",
			"lua_ls",
			"html",
			"eslint",
			"stylelint_lsp",
		},
	},
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
		{ "j-hui/fidget.nvim", opts = {} },
	},
}
