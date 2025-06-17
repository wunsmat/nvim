M = {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			java = { "google-java-format" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			groovy = { "npm-groovy-lint" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
	},
}

return M
