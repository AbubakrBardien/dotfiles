local common_deps = require("dependency_list")

------------------- None-ls Setup, communicatiing with Mason, and Auto-installations  -------------------
return {
	{
		-- This magically converts certain terminal tools into LSPs
		"nvimtools/none-ls.nvim", -- yes, the URL is correct
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting

			null_ls.setup({
				sources = {
					formatting.stylua, -- lua
					formatting.clang_format, -- c, c#, c++, json, java, javascript
					formatting.black, -- python
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
				automatic_installation = true,
				ensure_installed = {
					-- Linters
					"shellcheck",
				},
			})
		end,
	},
}
