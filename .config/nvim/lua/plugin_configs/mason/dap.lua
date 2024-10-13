local common_deps = require("dependency_list")

------------------- DAP UI and Auto-Installations -------------------
return {
	{
		{
			-- Tool to bridge the gap between "mason.nvim" with "nvim-dap"
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = {
				common_deps["mason"],
				common_deps["nvim_dap"],
			},
			config = function()
				require("mason-nvim-dap").setup {
					ensure_installed = { "codelldb", "debugpy" },
					handlers = {}, -- sets up dap in the predefined manner
				}
			end,
		},
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				common_deps["nvim_dap"],
				"nvim-neotest/nvim-nio",
				"theHamsta/nvim-dap-virtual-text", -- shows variable values right next to variables
			},
			config = function()
				local dap, dapui = require("dap"), require("dapui")
				dapui.setup()

				-- auto-generate the debug windows/elements
				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.launch.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end
				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end

				require("nvim-dap-virtual-text").setup {
					virt_text_pos = "eol", -- end of line
				}
			end,
		},
	},
}
