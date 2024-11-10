return {
	{
		-- Package Manager for LSPs, DAPs, Linters, and Formatters
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	require("plugin_configs.mason.lsp_config"),

	require("plugin_configs.mason.none-ls"),

	---@diagnostic disable-next-line: different-requires
	require("plugin_configs.mason.dap"),
}
