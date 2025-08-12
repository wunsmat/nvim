vim.pack.add({
	"https://github.com/folke/flash.nvim",
})

require("flash").setup({
	modes = {
		search = {
			enabled = true,
		},
		char = {
			jump_labels = true,
		},
	},
	jump = {
		nohlsearch = true,
	},
})

local map = require("utils").map
map("s", require("flash").jump, "Flash", { "n", "x", "o" })
map("S", require("flash").treesitter, "Flash Treesitter", { "n", "x", "o" })
map("r", require("flash").remote, "Remote Flash", "o")
map("R", require("flash").treesitter_search, "Treesitter Search", { "o", "x" })
map("<c-s>", require("flash").toggle, "Toggle Flash Search", "c")
