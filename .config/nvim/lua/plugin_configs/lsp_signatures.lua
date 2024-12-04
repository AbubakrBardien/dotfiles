return {
	-- displays function signatures
	"ray-x/lsp_signature.nvim",
	config = function()
		require("lsp_signature").setup {
			hint_enable = false,
			handler_opts = { border = "rounded" },
			max_width = 65,
		}
	end,
}
