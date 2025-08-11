vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
})

require("oil").setup()

local map = require("utils").map
map("-", "<CMD>Oil<CR>", "Open parent directory")
