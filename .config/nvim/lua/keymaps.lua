local map = vim.keymap.set

------ Telescope ------
local telescope = require("telescope")
local telescope_builtins = require("telescope.builtin")
local telescope_actions = require("telescope.actions")

map("n", "<leader>ff", telescope_builtins.find_files, { desc = "Find Files" })
map("n", "<leader>fp", telescope_builtins.live_grep, { desc = "Fuzzy-find in Project" })
map("n", "<leader>fb", telescope_builtins.buffers, { desc = "Search Buffers" })
map("n", "<leader>fh", telescope_builtins.help_tags, { desc = "Search Help Tags" })
map("n", "<leader>fr", telescope_builtins.oldfiles, { desc = "Search Recent Files" })
map("n", "<leader>fz", telescope_builtins.current_buffer_fuzzy_find, { desc = "Fuzzy-find in File" })
-- In future, create a custom picker to only show custom keymaps (the mappings in this buffer)
map("n", "<leader>fk", telescope_builtins.keymaps, { desc = "Search Keymaps" })

telescope.setup({ defaults = { mappings = { i = { ["<esc>"] = telescope_actions.close } } } })

------ NvimTree ------
map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree" })

------ LSP ------
map("n", "<C-k>", vim.lsp.buf.hover, { desc = "Display Hover Information" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "gr", ":Telescope lsp_references<CR>", { desc = "Find References" })
map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "Rename Symbol" })

map("n", "gdf", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gdc", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })

------ LSP Signatures ------
map("n", "<C-l>", function()
	require("lsp_signature").toggle_float_win()
end, { silent = true, desc = "Toggle Signature" })

------ Snippets ------
local luasnip = require("luasnip")

-- execute in "Insert Mode", or "Select Mode"
map({ "i", "s" }, "<C-k>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end, { silent = true, desc = "Jump to Previous snippet placeholder" })

map({ "i", "s" }, "<C-l>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { silent = true, desc = "Jump to Next snippet placeholder" })

------ Auto-Completions ------
local cmp = require("cmp")
local scroll_speed = 4
cmp.setup {
	mapping = {
		["<C-Space>"] = function(fallback) -- toggle completion menu
			if cmp.visible() then
				cmp.close()
			elseif not cmp.visible() then
				cmp.complete()
			else
				fallback()
			end
		end,
		["<CR>"] = function(fallback) -- comfirm completion entry (confirm 1st entry if none is selected)
			if cmp.visible() then
				cmp.confirm({ select = true })
			else
				fallback()
			end
		end,
		-- Up and Down arrow keys to navigate completions
		["<Up>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end,
		["<Down>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end,
		-- Left and Right arrow keys to scroll documentation
		["<Left>"] = function(fallback)
			if cmp.visible_docs() then
				cmp.scroll_docs(-scroll_speed)
			else
				fallback()
			end
		end,
		["<Right>"] = function(fallback)
			if cmp.visible_docs() then
				cmp.scroll_docs(scroll_speed)
			else
				fallback()
			end
		end,
	},
}

------ Debugger ------
local dap = require("dap")
map("n", "<F1>", dap.continue, { desc = "DAP: Continue" })
map("n", "<F2>", dap.step_over, { desc = "DAP: Step Over" })
map("n", "<F3>", dap.step_into, { desc = "DAP: Step Into" })
map("n", "<F4>", dap.step_out, { desc = "DAP: Step Out" })
map("n", "<F11>", dap.terminate, { desc = "DAP: Terminate" })
map("n", "<leader>db", function()
	if vim.api.nvim_get_current_line() ~= "" then -- Check if the line is not empty
		dap.toggle_breakpoint()
	end
end, { desc = "DAP: Toggle Breakpoint" })

map("n", "<Space>/", function()
	require("dapui").eval(nil, { enter = true })
end, { desc = "DAPUI: Eval var under cursor" })

------ Terminal ------
map({ "n" }, "<C-.>", ":FloatermNew<CR>", { desc = "Open new terminal window" })
map({ "n" }, "<C-/>", ":FloatermToggle<CR>", { desc = "Toggle terminal window" })
map({ "n" }, "<C-'>", ":FloatermKill<CR>", { desc = "Kill terminal window" })
vim.api.nvim_command("tnoremap <C-;> <C-\\><C-n>") -- Switch to "Normal Mode" from the terminal

------ Split View Mappings ------
map({ "n" }, "<A-Up>", "<C-w>k", { desc = "Go to Top window" })
map({ "n" }, "<A-Down>", "<C-w>j", { desc = "Go to Bottom window" })
map({ "n" }, "<A-Right>", "<C-w>l", { desc = "Go to Right window" })
map({ "n" }, "<A-Left>", "<C-w>h", { desc = "Go to Left window" })
map({ "n" }, "<A-a>", ":vs<CR><C-w>l", { desc = "Horizontal Split" })
map({ "n" }, "<A-s>", ":sp<CR><C-w>j", { desc = "Vertical Split" })
map({ "n" }, "<A-d>", ":q<CR>", { desc = "Close split window" })

------ Buffer Navigation ------
map({ "n" }, "<Tab>", ":bnext<CR>", { desc = "Go to Next Buffer" })
map({ "n" }, "<S-Tab>", ":bprevious<CR>", { desc = "Go to Previous Buffer" })

------ Other ------
map("n", "<C-s>", ":w<CR>", {})
map("n", ";", ":", { desc = "Enter Command Mode" })
map("n", "<Esc>", ":noh<CR>", { desc = "Clear Highlights" })
map("n", "<C-a>", "gg0vG$", { desc = "Highlight File" })
map("n", "<C-c>", "gg0vG$y", { desc = "Copy File Content" })
map("n", "<leader>s", ":source %<CR>", { desc = "Restart Neovim" })
