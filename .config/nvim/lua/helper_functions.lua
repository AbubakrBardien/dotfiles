local M = {}

---@diagnostic disable-next-line: unused-function, unused-local
function M.pandoc_convert(format)
	local current_file = vim.fn.expand("%")
	local output_file = vim.fn.expand("%:r") .. "." .. format

	local cmd = "pandoc " .. current_file .. " -o " .. output_file
	local success, result = pcall(vim.fn.system, cmd)

	if success then
		print(string.format("Converted %s to %s", current_file, output_file))
	else
		print(string.format("Pandoc conversion failed: %s", result))
	end
end

return M
