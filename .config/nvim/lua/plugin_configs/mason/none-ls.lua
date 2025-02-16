local common_deps = require("dependency_list")

------------------- None-ls Setup, communicatiing with Mason, and Auto-installations  -------------------
return {
	{
		-- This magically converts certain terminal tools into LSPs
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			-- local diagnostics = null_ls.builtins.diagnostics

			null_ls.setup({
				sources = {
					formatting.stylua,
				},
			})
		end,
	},
	{
		-- Tool to bridge the gap between "mason.nvim" and "none-ls"
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			common_deps["mason"],
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "shellcheck", "shfmt" },
			})
		end,
	},
}
