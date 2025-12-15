return {
	"mxsdev/nvim-dap-vscode-js",
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		require("dapui").setup()
		require("nvim-dap-virtual-text").setup({})

		require("dap-vscode-js").setup({
			debugger_path = "/home/kennyek/dev/microsoft/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		})

		local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

		for _, language in ipairs(js_filetypes) do
			require("dap").configurations[language] = {}
		end

		if not dap.adapters["node"] then
			dap.adapters["node"] = function(cb, config)
				if config.type == "node" then
					config.type = "pwa-node"
				end
				local nativeAdapter = dap.adapters["pwa-node"]
				if type(nativeAdapter) == "function" then
					nativeAdapter(cb, config)
				else
					cb(nativeAdapter)
				end
			end
		end

		vim.keymap.set("n", "<space>db", dap.toggle_breakpoint, { desc = "[T]oggle breakpoint" })
		vim.keymap.set("n", "<space>dg", dap.run_to_cursor, { desc = "[T]oggle breakpoint" })

		-- Eval var under cursor
		vim.keymap.set("n", "<space>?", function()
			require("dapui").eval(nil, { enter = true })
		end, { desc = "Evaluate value" })

		vim.keymap.set("n", "<space>dc", dap.continue, { desc = "[C]ontinue debugging" })
		vim.keymap.set("n", "<space>di", dap.step_into, { desc = "Step [I]nto" })
		vim.keymap.set("n", "<space>dn", dap.step_over, { desc = "Go to [N]ext breakpoint" })
		vim.keymap.set("n", "<space>do", dap.step_out, { desc = "Step [O]ut" })
		vim.keymap.set("n", "<space>db", dap.step_back, { desc = "Step [B]ack" })
		vim.keymap.set("n", "<space>dr", dap.restart, { desc = "[R]estart" })
		vim.keymap.set("n", "<space>dq", dap.terminate, { desc = "[Q]uit" })

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
