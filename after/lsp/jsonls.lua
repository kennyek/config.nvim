return {
	on_attach = function(client)
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}
