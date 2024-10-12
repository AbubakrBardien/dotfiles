local function tbl_to_str(t) -- needed for clang-format, and yapf
	local str = ""
	for _, i in ipairs(t) do
		str = str .. i .. ", "
	end
	-- stylua: ignore
	return '\'{' .. string.sub(str, 1, -3) .. '}\''
end

local clang_format = require("formatter_configs.clang_format")

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	group = vim.api.nvim_create_augroup("Auto-format", { clear = true }),
	callback = function()
		local ft = vim.bo.filetype
		local DIR_PATH = "$HOME/.config/nvim/lua/formatter_configs/"

		if ft == "lua" then
			vim.api.nvim_command(':silent execute "!stylua -f ' .. DIR_PATH .. 'stylua.toml %"')
		elseif ft == "c" or ft == "cpp" then
			vim.api.nvim_command(':silent execute "!clang-format --style=' .. tbl_to_str(clang_format) .. ' -i %"')
		end
		-- Python auto-formatting is a pain to set up with tabs as indents, so I'm skipping that
	end,
})
