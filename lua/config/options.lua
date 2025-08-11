vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

local function paste()
	return {
		vim.fn.split(vim.fn.getreg(""), "\n"),
		vim.fn.getregtype(""),
	}
end

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = paste,
		["*"] = paste,
	},
}
vim.o.mouse = "a"
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.cursorcolumn = false
vim.o.incsearch = true
vim.o.confirm = true
vim.o.undofile = true
vim.o.scrolloff = 10
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.breakindent = true
vim.o.showmode = false
