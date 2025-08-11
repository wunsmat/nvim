vim.pack.add({
	"https://github.com/mfussenegger/nvim-jdtls",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("jdtls-keymaps", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.name == "jdtls" then
			local jdtls = require("jdtls")
			vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, {
				buffer = event.buf,
				desc = "[O]rganize Imports",
			})
			vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, {
				buffer = event.buf,
				desc = "Extract [V]ariable",
			})
			vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, {
				buffer = event.buf,
				desc = "Extract [C]onstant",
			})
			vim.keymap.set({ "n", "v" }, "<leader>jm", jdtls.extract_method, {
				buffer = event.buf,
				desc = "Extract [M]ethod",
			})
		end
	end,
})
