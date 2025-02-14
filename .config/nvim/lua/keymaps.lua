local custom_picker = require("plugin_configs.fuzzy_finder.custom_picker")

local map = vim.keymap.set

------ Telescope ------
local telescope = require("telescope")
local telescope_builtins = require("telescope.builtin")
local telescope_actions = require("telescope.actions")

map("n", "<leader>ff", telescope_builtins.find_files,                { desc = "Find Files" })
map("n", "<leader>fp", telescope_builtins.live_grep,                 { desc = "Fuzzy-find in Project" })
map("n", "<leader>fb", telescope_builtins.buffers,                   { desc = "Search Buffers" })
map("n", "<leader>fh", telescope_builtins.help_tags,                 { desc = "Search Help Tags" })
map("n", "<leader>fr", telescope_builtins.oldfiles,                  { desc = "Search Recent Files" })
map("n", "<leader>fz", telescope_builtins.current_buffer_fuzzy_find, { desc = "Fuzzy-find in File" })
map("n", "<leader>fk", telescope_builtins.keymaps,                   { desc = "Search Keymaps" })

-- Custom Telescope Picker to search in the Source Code directories of installed plugins
map("n", "<leader>fsc", function()
	telescope_builtins.find_files {
		---@diagnostic disable-next-line: param-type-mismatch
		cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
	}
end)

telescope.setup({ defaults = { mappings = { i = { ["<esc>"] = telescope_actions.close } } } })

------ NvimTree ------
map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree" })

------ LSP ------
map("n", "<C-k>",          vim.lsp.buf.hover,                 { desc = "Display Hover Information" })
map({ "n", "i" }, "<C-l>", vim.lsp.buf.signature_help,        { desc = "Display Signature Help" })
map("n", "gca",            vim.lsp.buf.code_action,           { desc = "Code Action" })
map("n", "gra",            vim.lsp.buf.rename,                { desc = "Rename Symbol" })
map("n", "gdf",	           vim.lsp.buf.definition,            { desc = "Go to Definition" })
map("n", "grr",	           telescope_builtins.lsp_references, { desc = "Find References" })
map("n", "gdc",	           vim.lsp.buf.declaration,	          { desc = "Go to Declaration" })
map("n", "gi",             vim.lsp.buf.implementation,        { desc = "Go to Implementation" })

-- Auto-completion keymaps are in the "plugin_configs/auto_completions.lua" file

------ Debugger ------
local dap = require("dap")
local dapui = require("dapui")
map("n", "<leader>dc", dap.continue,  { desc = "DAP: Continue" })
map("n", "<leader>n",  dap.step_over, { desc = "DAP: Step Over" })
map("n", "<leader>db", dap.step_back, { desc = "DAP: Step Back" })
map("n", "<leader>di", dap.step_into, { desc = "DAP: Step Into" })
map("n", "<leader>do", dap.step_out,  { desc = "DAP: Step Out" })

map("n", "<leader>dt", function()
	dap.terminate()
	dapui.close()
end, { desc = "DAP: Terminate" })

map("n", "<leader>b", function()
	if vim.api.nvim_get_current_line() ~= "" then -- Check if the line is not empty
		dap.toggle_breakpoint()
	end
end, { desc = "DAP: Toggle Breakpoint" })

map("n", "<leader>B", function()
	if vim.api.nvim_get_current_line() ~= "" then
		vim.ui.input({ prompt = "Enter Condition:" }, function(condition) dap.toggle_breakpoint(condition) end)
	end
end, { desc = "DAP: Toggle Conditional Breakpoint" })

map("n", "<Space>/", function()
	---@diagnostic disable-next-line: missing-fields
	dapui.eval(nil, { enter = true })
end, { desc = "DAPUI: Eval var under cursor" })

------ GitSigns ------
local gitsigns = require("gitsigns")
map("n", "]c",         function() gitsigns.nav_hunk("next") end,            { desc = "Go to Next Hunk" })
map("n", "[c",         function() gitsigns.nav_hunk("prev") end,            { desc = "Go to Previous Hunk" })
map("n", "<leader>hp", function() gitsigns.preview_hunk_inline() end,       { desc = "Preview Hunk" })
map("n", "<leader>ht", function() gitsigns.stage_hunk() end,                { desc = "Stage/Unstage Hunk" })
map("n", "<leader>tb", function() gitsigns.toggle_current_line_blame() end, { desc = "Toggle Git Blame" })

------ Terminal ------
map("n", "<C-.>", ":FloatermNew<CR>",    { desc = "Open new terminal window" })
map("n", "<C-/>", ":FloatermToggle<CR>", { desc = "Toggle terminal window" })
map("n", "<C-'>", ":FloatermKill<CR>",   { desc = "Kill terminal window" })
vim.api.nvim_command("tnoremap <C-;> <C-\\><C-n>") -- Switch to "Normal Mode" from the terminal

------ Split View Mappings ------
map("n", "<A-Up>",    "<C-w>k",        { desc = "Go to Top window" })
map("n", "<A-Down>",  "<C-w>j",        { desc = "Go to Bottom window" })
map("n", "<A-Right>", "<C-w>l",        { desc = "Go to Right window" })
map("n", "<A-Left>",  "<C-w>h",        { desc = "Go to Left window" })
map("n", "<A-q>",     ":vs<CR><C-w>l", { desc = "Horizontal Split" })
map("n", "<A-w>",     ":sp<CR><C-w>j", { desc = "Vertical Split" })
map("n", "<A-e>",     ":q<CR>",        { desc = "Close split window" })

------ Buffer Navigation ------
map("n", "<Tab>",   ":bnext<CR>",     { desc = "Go to Next Buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Go to Previous Buffer" })

------ File Conversion ------
map("n", "<leader>fc", function() custom_picker:find() end, { desc = "Open File Conversion Menu" })

------ Preview ------
map("n", "<leader>po", ":PeekOpen<CR>",	 { desc = "Open Preview" })
map("n", "<leader>pc", ":PeekClose<CR>", { desc = "Close Preview" })

------ Colorizer ------
map("n", "<leader>cr", ":ColorizerReloadAllBuffers<CR>", { desc = "Reload Colorizer plugin" })

------ Trailspace ------
map("n", "<leader>tr", ":=MiniTrailspace.trim()<CR>", { desc = "Remove Trailing Whitespace" })

------ Other ------
map("n", "<C-s>",     ":w<CR>",        { desc = "Save File" })
map("n", ";",         ":",             { desc = "Enter Command Mode" })
map("n", "<Esc>",     ":noh<CR>",      { desc = "Clear Highlights" })
map("n", "<C-a>",     "gg0vG$",        { desc = "Highlight File" })
map("n", "<C-c>",     "gg0vG$y",       { desc = "Copy File Content" })
map("n", "<leader>s", ":source %<CR>", { desc = "Restart Neovim" })
map("n", "<C-d>",     ":bd<CR>",       { desc = "Delete Buffer" })
