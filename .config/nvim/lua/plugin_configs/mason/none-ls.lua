local common_deps = require("dependency_list")

------------------- None-ls Setup, communicatiing with Mason, and Auto-installations  -------------------
return {
	{
		-- Tool to bridge the gap between "mason.nvim" with the "none-ls"
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			common_deps["mason"],
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup {
				-- Anything supported by mason
				ensure_installed = {
					-- Linters
					"shellcheck",

					-- Formatters
					"stylua",
					"clang-format",
				},

				-- formatter settings will be handled by my config (in auto_commands.lua)
				methods = { formatting = false },
			}
		end,
	},
	{
		-- This magically converts certain terminal tools into LSPs (I don't know)
		"nvimtools/none-ls.nvim", -- yes, the URL is correct
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup {
				-- Anything NOT supported by mason
				sources = {},
			}
		end,
	},
}
