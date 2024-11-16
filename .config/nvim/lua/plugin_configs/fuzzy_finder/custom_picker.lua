local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function enter(prompt_bufnr)
	local selected_entry = action_state.get_selected_entry()
	local format = ""

	if selected_entry[1] == "PDF" then
		format = "pdf"
	elseif selected_entry[1] == "WORD" then
		format = "docx"
	end

	actions.close(prompt_bufnr)

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

local opts = {
	finder = finders.new_table { "PDF", "WORD" },
	sorter = sorters.get_generic_fuzzy_sorter(),

	layout_config = {
		height = 0.25,
		width = 0.25,
	},

	prompt_title = "Convert File To",

	---@diagnostic disable-next-line: unused-local
	attach_mappings = function(prompt_bufnr, map)
		map("i", "<CR>", enter)
		return true
	end,
}

local conversions = pickers.new(opts)
return conversions
