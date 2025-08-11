M = {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		picker = {},
		notifier = {},
	},
	keys = {
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files in project directory",
		},
		{
			"<leader>sif",
			function()
				Snacks.picker.files({ cwd = "/home/vagrant/dev/repos/IMPACT" })
			end,
			desc = "Find files in the entire IMPACT project",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Find by grepping in project directory",
		},
		{
			"<leader>sig",
			function()
				Snacks.picker.grep({ cwd = "/home/vagrant/dev/repos/IMPACT" })
			end,
			desc = "Find by grepping in IMPACT directory",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find in neovim configuration",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "[F]ind [H]elp",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "[F]ind [K]eymaps",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.pickers()
			end,
			desc = "[F]ind [B]uiltin Pickers",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "[F]ind current [W]ord",
		},
		{
			"<leader>sW",
			function()
				Snacks.picker.grep_word({ word_match = "-w" })
			end,
			desc = "[F]ind current [W]ORD",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[F]ind [D]iagnostics",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.resume()
			end,
			desc = "[F]ind [R]esume",
		},
		{
			"<leader>so",
			function()
				Snacks.picker.recent()
			end,
			desc = "[F]ind [O]ld Files",
		},
		{
			"<leader><leader>",
			function()
				Snacks.picker.buffers()
			end,
			desc = "[,] Find existing buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.lines()
			end,
			desc = "[/] Live grep the current buffer",
		},
	},
}

return M
