vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
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
})
