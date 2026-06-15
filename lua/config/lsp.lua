local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

local default_keymaps = {
	{ keys = "<leader>ca", func = vim.lsp.buf.code_action, desc = "Code Actions" },
	{ keys = "<leader>cr", func = vim.lsp.buf.rename, desc = "Code Rename" },
}

vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("lsp_attach"),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local buf = args.buf
		if client then
			for _, km in ipairs(default_keymaps) do
				vim.keymap.set(
					km.mode or "n",
					km.keys,
					km.func,
					{ buffer = buf, desc = "LSP: " .. km.desc, nowait = km.nowait }
				)
			end
		end
	end,
})
