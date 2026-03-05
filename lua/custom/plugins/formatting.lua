return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			local timeout = { groovy = 5000, json = 1000 }
			local lsp_timeout_opt
			if timeout[vim.bo[bufnr].filetype] then
				lsp_timeout_opt = timeout[vim.bo[bufnr].filetype]
			else
				lsp_timeout_opt = 500
			end
			return {
				timeout_ms = lsp_timeout_opt,
				lsp_format = "fallback",
			}
		end,
		formatters_by_ft = {
			groovy = { "npm_groovy_lint" },
			lua = { "stylua" },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			json = { "biome_if_configured" },
			javascript = { "biome_if_configured" },
			javascriptreact = { "biome_if_configured" },
			typescript = { "biome_if_configured" },
			typescriptreact = { "biome_if_configured" },
		},
		formatters = {
			biome_if_configured = {
				inherit = false,
				command = "biome",
				args = { "format", "--stdin-file-path", "$FILENAME" },
				stdin = true,
				condition = function(ctx)
					local biome_config =
						vim.fs.find("biome.json", { upward = true, path = ctx.filename, type = "file" })
					return #biome_config > 0
				end,
			},
			npm_groovy_lint = {
				command = "npm-groovy-lint",
				args = { "--format", "$FILENAME" },
				stdin = false,
			},
		},
	},
}
