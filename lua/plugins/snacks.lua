vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
	input = { enabled = false },
	picker = { enabled = true },
	notifier = { enabled = false },
})

local map = require("utils").map

-- Snacks picker keymaps
local impact_files = function()
	Snacks.picker.files({ cwd = "/home/vagrant/dev/repos/IMPACT" })
end

local impact_grep = function()
	Snacks.picker.grep({ cwd = "/home/vagrant/dev/repos/IMPACT" })
end

local config_files = function()
	Snacks.picker.files({
		cwd = vim.fn.stdpath("config"),
	})
end

local grep_word = function()
	Snacks.picker.grep_word({ word_match = "-w" })
end

map("<leader>ss", Snacks.picker.smart, "Smart Find Files in project directory")
map("<leader>sf", Snacks.picker.files, "Find Files in project directory")
map("<leader>sg", Snacks.picker.grep, "Find by grepping in project directory")
map("<leader>sif", impact_files, "Find files in the entire IMPACT project")
map("<leader>sig", impact_grep, "Find by grepping in IMPACT directory")
map("<leader>sc", config_files, "Find in neovim configuration")
map("<leader>sh", Snacks.picker.help, "[F]ind [H]elp")
map("<leader>sk", Snacks.picker.keymaps, "[F]ind [K]eymaps")
map("<leader>sb", Snacks.picker.pickers, "[F]ind [B]uiltin Pickers")
map("<leader>sw", Snacks.picker.grep_word, "[F]ind current [W]ord")
map("<leader>sW", grep_word, "[F]ind current [W]ORD")
map("<leader>sa", Snacks.picker.diagnostics, "[F]ind [D]iagnostics")
map("<leader>sd", Snacks.picker.diagnostics_buffer, "[F]ind [D]iagnostics")
map("<leader>sr", Snacks.picker.resume, "[F]ind [R]esume")
map("<leader>so", Snacks.picker.recent, "[F]ind [O]ld Files")
map("<leader><leader>", Snacks.picker.buffers, "[,] Find existing buffers")
map("<leader>/", Snacks.picker.lines, "[/] Live grep the current buffer")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("snacks-lsp-keymaps", { clear = true }),
	callback = function(event)
		map("grr", Snacks.picker.lsp_references, "[G]oto [R]eferences")
		map("gri", Snacks.picker.lsp_implementations, "[G]oto [I]mplementation")
		map("grd", Snacks.picker.lsp_definitions, "[G]oto [D]efinition")
		map("gO", Snacks.picker.lsp_symbols, "Open Document Symbols")
		map("gW", Snacks.picker.lsp_workspace_symbols, "Open Workspace Symbols")
		map("grt", Snacks.picker.lsp_type_definitions, "[G]oto [T]ype Definition")
	end,
})
