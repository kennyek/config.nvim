return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },
	version = '1.*',
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'default',
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = 'normal',
		},
		completion = { documentation = { auto_show = false } },
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		signature = { enabled = true },
		fuzzy = { implementation = 'prefer_rust_with_warning' },
	},
	opts_extend = { 'sources.default' },
}
