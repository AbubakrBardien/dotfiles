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

			-- allows LSPs to communicate with "cmp_nvim_lsp" to provide language-specific completions
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- this is where you configure each LSP
			local lsp_set = { "lua_ls", "clangd", "pyright", "bashls", "cssls" }
			for _, lsp in pairs(lsp_set) do
				lspconfig[lsp].setup { capabilities = capabilities }
			end
		end,
	},
}
