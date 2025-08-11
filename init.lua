require("config.options")
require("config.keymaps")

vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-lua/plenary.nvim",
})

require("plugins.tokyonight")
require("plugins.treesitter")
require("plugins.snacks")
require("plugins.oil")
require("plugins.nvim-jdtls")
require("plugins.ng")
require("plugins.conform")
require("plugins.zellij-nav")
require("plugins.typescript-tools")
require("plugins.copilot")
require("plugins.blink")
require("plugins.lsp")
require("plugins.flash")
require("plugins.lualine")
require("plugins.noice")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
