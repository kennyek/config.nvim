return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		---@module 'neo-tree'
		---@type neotree.Config
		opts = {
			window = {
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_ignored = false,
					},
				},
			},
		}
	},

	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-s>"] = false,
				["<C-h>"] = false,
				["<C-t>"] = false,
				["<C-l>"] = false,
			},
		},
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		config = function()
			require("oil").setup({})
			vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
		end,
		lazy = false,
	}
}
