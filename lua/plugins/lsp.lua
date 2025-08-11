vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = require("utils").map
		map("grf", vim.lsp.buf.format, "[F]ormat")
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		-- map("grr", vim.lsp.buf.references, "[G]oto [R]eferences")
		-- map("gri", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		-- map("grd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		-- map("gO", vim.lsp.buf.document_symbol, "Open Document Symbols")
		-- map("gW", vim.lsp.buf.workspace_symbol, "Open Workspace Symbols")
		-- map("grt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

local toggle_diagnostics = function()
	local current_config = vim.diagnostic.config()
	local new_virtual_text_state = current_config and not (current_config.virtual_text or false)
	vim.diagnostic.config({ virtual_text = new_virtual_text_state })
end

vim.keymap.set("n", "<leader>v", toggle_diagnostics, { desc = "Toggle diagnostic virtual text" })

local capabilities = require("blink.cmp").get_lsp_capabilities()

local lua_ls_setup = {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
}

local servers = {
	angularls = {},
	jdtls = {},
	bashls = {},
	groovyls = {},
	lua_ls = lua_ls_setup,
	pylsp = {},
}

local lsp_servers = vim.tbl_keys(servers or {})
local ensure_installed = vim.deepcopy(lsp_servers)
vim.list_extend(ensure_installed, {
	"stylua",
	"prettierd",
	"google-java-format",
	"npm-groovy-lint",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

vim.lsp.enable(lsp_servers)
for key, value in pairs(servers) do
	value.capabilities = vim.tbl_deep_extend("force", {}, capabilities, value.capabilities or {})
	vim.lsp.config(key, value)
end
