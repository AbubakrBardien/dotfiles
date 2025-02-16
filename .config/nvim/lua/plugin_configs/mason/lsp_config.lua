------------------------- LSP Setup and Auto-Installations -------------------------

-- local lsp_set = { "lua_ls", "ruff", "bashls" }
local lsp_set = { "lua_ls", "clangd", "pyright", "bashls", "cssls" }

return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Tool to bridge the gap between "mason.nvim" and "lspconfig"
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup {
				ensure_installed = lsp_set,
			}
		end,
	},
	{
		-- Allows Neovim to communicate with Language Servers
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/lazydev.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			for _, lsp in pairs(lsp_set) do
				if lsp == "clangd" then
					lspconfig[lsp].setup { -- "clang-tidy" is the built-in linter
						cmd = { "clangd", "--offset-encoding=utf-16", "--clang-tidy" },
					}
				else
					lspconfig[lsp].setup {}
				end
			end
		end,
	},
	-- Check the docs in both repos to verify if a language server can be auto-installed and configured
}
