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
					formatting.stylua, -- lua
					-- formatting.black, -- python
					-- The "clangd" LSP has "clang-format" built-in
				},
			})
		end,
		-- "lua_ls" has a built in formatter, but I'm keeping "stylua" becuase it has extra features that I use
		-- Not sure if I should use a python formatter at all, since basically none of them allow tab indentation
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
					"shellcheck", -- Linter, installed as a dependency for the Bash LSP (Bashls)
					"shfmt", -- Formatter, installed as a dependency for the Bash LSP (Bashls)
				},
			})
		end,
	},
}
