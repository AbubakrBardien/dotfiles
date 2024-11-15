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
		-- Allows Neovim to communicate with Language Servers
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Allows LSPs to communicate with "cmp_nvim_lsp" to provide language-specific completions
			local cmp_nvim_lsp = require("cmp_nvim_lsp").default_capabilities()

			-- Doing the same configuration for multiple LSPs
			local lsp_set = { "lua_ls", "pyright", "bashls", "cssls" }
			for _, lsp in pairs(lsp_set) do
				lspconfig[lsp].setup { capabilities = cmp_nvim_lsp }
			end

			-- Seperate LSP config for clangd (It fixes this: https://www.reddit.com/r/neovim/comments/12qbcua/multiple_different_client_offset_encodings/)
			lspconfig.clangd.setup {
				capabilities = cmp_nvim_lsp,
				cmd = { "clangd", "--offset-encoding=utf-16" },
			}
		end,
	},
}
