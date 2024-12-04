local common_deps = require("dependency_list")
local custom_theme = require("plugin_configs.statusline.custom_theme")

local function location()
	local row = vim.fn.line(".")
	local col = vim.fn.col(".")
	return "row " .. row .. ", " .. "col " .. col
end

local function file_size()
	local bytes = vim.fn.getfsize(vim.fn.expand("%"))
	local sizes = { "B", "KB", "MB", "GB" }
	local i = 1

	while bytes >= 1024 do
		bytes = bytes / 1024.0
		i = i + 1
	end

	if bytes % 1 == 0 then
		return string.format("%.0f %s", bytes, sizes[i])
	else
		return string.format("%.1f %s", bytes, sizes[i])
	end
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { common_deps["mini_icons"] },
	config = function()
		require("lualine").setup {
			options = {
				globalstatus = true,
				theme = custom_theme,
				ignore_focus = { "NvimTree", "TelescopePrompt", "lazy", "mason" },
				always_divide_middle = false,

				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				-- lualine_b = { "branch", "diff" },
				lualine_b = { "branch" },
				lualine_c = { "filetype", "filename" },
				lualine_x = { file_size },
				lualine_y = { location, "progress" },
				lualine_z = {},
			},
		}
	end,
}
