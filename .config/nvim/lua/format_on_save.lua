vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	group = vim.api.nvim_create_augroup("Auto-format", { clear = true }),
	callback = function()
		local ft = vim.bo.filetype
		if ft == "lua" or ft == "c" or ft == "cpp" or ft == "python" then
			vim.api.nvim_command(":lua vim.lsp.buf.format()")
		end
	end,
})
