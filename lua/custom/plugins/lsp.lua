return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"bashls",
				"biome",
				"copilot",
				"cssls",
				"docker_language_server",
				"gh_actions_ls",
				"groovyls",
				"html",
				"jsonls",
				"lua_ls",
				"markdown_oxide",
				"ts_ls",
				"vtsls",
				"yamlls",
			}
		},
	}
}
