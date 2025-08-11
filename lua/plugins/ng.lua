vim.pack.add({
	"https://github.com/joeveiga/ng.nvim",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("ng-keymaps", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.name == "angularls" then
			local ng = require("ng")
			vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, {
				buffer = event.buf,
				noremap = true,
				silent = true,
				desc = "Goto [A]ngular [T]emplate",
			})
			vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, {
				buffer = event.buf,
				noremap = true,
				silent = true,
				desc = "Goto [A]ngular [C]omponent",
			})
		end
	end,
})
