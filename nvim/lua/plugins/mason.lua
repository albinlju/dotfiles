return {
	"mason-org/mason.nvim",
	priority = 1000,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		ui = { border = "rounded" },
	},
	cmd = "Mason",
}
