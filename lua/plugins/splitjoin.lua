vim.pack.add({
	{
		src = "https://github.com/Wansmer/treesj",
		version = "main",
	},
})

local tsj = require('treesj')

tsj.setup({
  use_default_keymaps = false,
})

vim.keymap.set('n', '<leader>gS', tsj.toggle, { desc = "Toggle Split/Join (TreeSJ)" })
