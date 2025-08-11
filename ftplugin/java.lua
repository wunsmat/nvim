local mason_path = vim.fn.stdpath("data") .. "/mason"
local share_jdtls_path = mason_path .. '/share/jdtls'
local lombok_path = share_jdtls_path .. '/lombok.jar'
local jdtls_jar_path = share_jdtls_path .. "/plugins/org.eclipse.equinox.launcher.jar"
local os_path = mason_path .. '/packages/jdtls/config_linux'
local root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1])

local function get_workspace_dir()
	local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":p:h:t")
	return vim.fn.stdpath("data") .. "/workspace/" .. project_name
end

local config = {
	cmd = {
		'java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-javaagent:' .. lombok_path,
		'-Xmx4g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-jar', jdtls_jar_path,
		'-configuration', os_path,
		'-data', get_workspace_dir(),
	},
	root_dir = root_dir,
}
require('jdtls').start_or_attach(config)
