vim.lsp.config("jsonls", {
	on_attach = function(client)
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
})
