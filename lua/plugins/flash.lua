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
map("s", require("flash").jump, "Flash", { mode = { "n", "x", "o" } })
map("S", require("flash").treesitter, "Flash Treesitter", { mode = { "n", "x", "o" } })
map("r", require("flash").remote, "Remote Flash", { mode = "o" })
map("R", require("flash").treesitter_search, "Treesitter Search", { mode = { "o", "x" } })
map("<c-s>", require("flash").toggle, "Toggle Flash Search", { mode = { "c" } })
