vim.pack.add({
	"https://github.com/GR3YH4TT3R93/zellij-nav.nvim",
})

-- Zellij navigation setup
if os.getenv("ZELLIJ") == "0" then
	vim.g.zellij_nav_default_mappings = true
	require("zellij-nav").setup({})
end
