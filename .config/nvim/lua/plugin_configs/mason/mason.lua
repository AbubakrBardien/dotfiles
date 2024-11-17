return {
	{
		-- Package Manager for LSPs, DAPs, Linters, and Formatters
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup {
				ui = {
					icons = {
						package_pending = " ",
						package_installed = " ",
						package_uninstalled = " ",
					},
				},
			}
		end,
	},

	require("plugin_configs.mason.lsp_config"),

	require("plugin_configs.mason.none-ls"),

	require("plugin_configs.mason.dap"),
}
