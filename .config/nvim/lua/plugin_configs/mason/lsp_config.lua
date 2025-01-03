------------------------- LSP Setup and Auto-Installations -------------------------
return {
	{
		-- Tool to bridge the gap between "mason.nvim" and "lspconfig"
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup {
				automatic_installation = true, -- Auto-install LSPs if it's configured in "nvim-lspconfig"
			}
		end,
	},
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
		-- Allows Neovim to communicate with Language Servers
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/lazydev.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")

			-- Doing the same configuration for multiple LSPs
			-- local lsp_set = { "lua_ls", "ruff", "bashls" }
			local lsp_set = { "lua_ls", "pyright", "bashls" }
			for _, lsp in pairs(lsp_set) do
				lspconfig[lsp].setup {}
			end

			lspconfig["clangd"].setup { -- "clang-tidy" is the built-in linter
				cmd = { "clangd", "--offset-encoding=utf-16", "--clang-tidy" },
			}
		end,
	},
	-- Check the docs in both repos to verify if a language server can be auto-installed and configured
}
