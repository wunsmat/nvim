vim.pack.add({
	"https://github.com/pmizio/typescript-tools.nvim",
})

require("typescript-tools").setup({
	settings = {
		expose_as_code_action = "all",
	},
})
