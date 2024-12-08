local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		-- stylua: ignore
		if not client then return end

		if client.supports_method("textDocument/formatting") then
			-- Format the current buffer on save (except for 'keymaps.lua')
			autocmd("BufWritePre", {
				buffer = args.buf,
				callback = function()
					local filename = vim.fn.expand("%:t")
					if filename ~= "keymaps.lua" then
						vim.lsp.buf.format { bufnr = args.buf, id = client.id }
					end
				end,
			})
		end
	end,
})
