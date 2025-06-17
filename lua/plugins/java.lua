return {
	"nvim-java/nvim-java",
	dependencies = {
		{
			"neovim/nvim-lspconfig",
			config = {},
			opts = {
				servers = {
					jdtls = {
						settings = {
							java = {
								configuration = {
									runtimes = {
										{
											name = "JavaSE-21",
											path = "/home/vagrant/.sdkman/candidates/java/current",
										},
									},
								},
							},
						},
					},
				},
			},
		},
	},
}
