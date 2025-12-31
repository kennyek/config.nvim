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
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"biome",
					"copilot",
					"cssls",
					"docker_language_server",
					"gh_actions_ls",
					"gopls",
					"html",
					"jsonls",
					"lua_ls",
					"markdown_oxide",
					"ols",
					"vtsls",
					"yamlls",
				},
			})
		end,
	},
}
