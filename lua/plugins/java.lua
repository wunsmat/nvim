-- lua/plugins/java.lua
return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	dependencies = {
		"neovim/nvim-lspconfig",
		"mason.nvim",
	},
	config = function()
		local jdtls = require("jdtls")

		-- Function to find the root directory of the Java project
		local function get_jdtls_root()
			return require("jdtls.setup").find_root({
				"gradlew",
				"mvnw",
				".git",
				"pom.xml",
				"build.gradle",
				"build.gradle.kts",
				"settings.gradle",
				"settings.gradle.kts",
			})
		end

		-- Function to get workspace directory
		local function get_workspace_dir()
			local project_name = vim.fn.fnamemodify(get_jdtls_root() or vim.fn.getcwd(), ":p:h:t")
			return vim.fn.stdpath("data") .. "/workspace/" .. project_name
		end

		-- Configuration for jdtls
		local function get_jdtls_config()
			local home = os.getenv("HOME")
			local java_home = "/home/vagrant/.sdkman/candidates/java/current" -- Your Java path
			local mason_path = vim.fn.stdpath("data") .. "/mason"

			-- Find the jdtls installation path
			local jdtls_path = mason_path .. "/packages/jdtls"
			local jdtls_bin = jdtls_path .. "/bin/jdtls"

			-- Get blink.cmp capabilities
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local config = {
				cmd = {
					java_home .. "/bin/java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xmx2g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
					"-configuration",
					jdtls_path .. "/config_linux", -- Use config_mac on macOS, config_win on Windows
					"-data",
					get_workspace_dir(),
				},

				root_dir = get_jdtls_root(),

				capabilities = capabilities,

				settings = {
					java = {
						eclipse = {
							downloadSources = true,
						},
						configuration = {
							updateBuildConfiguration = "interactive",
							runtimes = {
								{
									name = "JavaSE-21",
									path = java_home,
								},
							},
						},
						maven = {
							downloadSources = true,
						},
						implementationsCodeLens = {
							enabled = true,
						},
						referencesCodeLens = {
							enabled = true,
						},
						references = {
							includeDecompiledSources = true,
						},
						format = {
							enabled = true,
							settings = {
								url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
								profile = "GoogleStyle",
							},
						},
					},
					signatureHelp = { enabled = true },
					completion = {
						favoriteStaticMembers = {
							"org.hamcrest.MatcherAssert.assertThat",
							"org.hamcrest.Matchers.*",
							"org.hamcrest.CoreMatchers.*",
							"org.junit.jupiter.api.Assertions.*",
							"java.util.Objects.requireNonNull",
							"java.util.Objects.requireNonNullElse",
							"org.mockito.Mockito.*",
						},
						importOrder = {
							"java",
							"javax",
							"com",
							"org",
						},
					},
					extendedClientCapabilities = jdtls.extendedClientCapabilities,
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
					codeGeneration = {
						toString = {
							template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
						},
						useBlocks = true,
					},
				},

				flags = {
					allow_incremental_sync = true,
				},

				init_options = {
					bundles = {},
				},

				on_attach = function(client, bufnr)
					-- Enable completion triggered by <c-x><c-o>
					vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

					-- Set up keymaps (same as your existing LSP keymaps)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
					end

					-- Java-specific keymaps
					map("<leader>co", jdtls.organize_imports, "Organize Imports")
					map("<leader>crv", jdtls.extract_variable, "Extract Variable")
					map("<leader>crc", jdtls.extract_constant, "Extract Constant")
					map("<leader>crm", jdtls.extract_method, "Extract Method", { "n", "v" })

					-- Standard LSP keymaps (if not already set globally)
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
					map("grr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
					map("gri", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
					map("grd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("grt", require("fzf-lua").lsp_typedefs, "[G]oto [T]ype Definition")

					-- Enable inlay hints if supported
					if client.supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end,
			}

			return config
		end

		-- Auto command to start jdtls for Java files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				local config = get_jdtls_config()
				jdtls.start_or_attach(config)
			end,
		})
	end,
}
