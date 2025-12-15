return {
	'folke/which-key.nvim',
	event = 'VimEnter',
	opts = {
		delay = 0,
		icons = {
			mappings = vim.g.have_nerd_font,
			keys = {},
		},
		spec = {
			{ '<leader>b', group = '[B]uffer' },
			{ '<leader>c', group = '[C]ode' },
			{ '<leader>e', group = '[E]xplorer' },
			{ '<leader>g', group = '[G]o to',     mode = { 'n', 'v' } },
			{ '<leader>h', group = 'Git [H]unks', mode = { 'n', 'v' } },
			{ '<leader>q', group = '[Q]uickfix' },
			{ '<leader>s', group = '[S]earch' },
			{ '<leader>t', group = '[T]oggle' },
			{ '<leader>w', group = '[W]indow' },
		},
	},
}
