vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
})

require("tokyonight").setup({
	transparent = true,
	styles = {
		floats = "transparent",
	},
})

vim.cmd("colorscheme tokyonight")
vim.cmd(":hi statusline guibg=NONE")
