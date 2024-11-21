--- Theme ---
vim.api.nvim_command("colorscheme onedark") -- "onedark" and "onedark_vivid" are the same

-- Dashboard
vim.api.nvim_command("highlight DashboardHeader guifg=#97C17C")
vim.api.nvim_command("highlight DashboardIcon guifg=#61A8E6")
vim.api.nvim_command("highlight DashboardDesc guifg=#61A8E6")
vim.api.nvim_command("highlight DashboardKey guifg=#5BB3C1")
vim.api.nvim_command("highlight DashboardFooter guifg=#4f4e5c")

-- File Tree
vim.api.nvim_command("highlight NvimTreeFolderIcon guifg=#71B0E8")
vim.api.nvim_command("highlight NvimTreeRootFolder guifg=#71B0E8")
vim.api.nvim_command("highlight NvimTreeFolderName guifg=#71B0E8")
vim.api.nvim_command("highlight NvimTreeEmptyFolderName guifg=#71B0E8")
vim.api.nvim_command("highlight NvimTreeOpenedFolderName guifg=#71B0E8")
vim.api.nvim_command("highlight NvimTreeSymlinkFolderName guifg=#71B0E8")

-- Dap Virtual Text
vim.api.nvim_command("highlight NvimDapVirtualText guifg=#4f4e5c")
vim.api.nvim_command("highlight NvimDapVirtualTextChanged guifg=#616073 gui=bold")

-- LSP Signature
vim.api.nvim_command("highlight LspSignatureActiveParameter gui=bold")

-- Cursor Highlights
vim.api.nvim_command("highlight CursorLine guibg=#2D313B")
vim.api.nvim_command("highlight CursorColumn guibg=#2D313B")
