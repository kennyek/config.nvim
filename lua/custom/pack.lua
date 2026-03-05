-- Plugin management using vim.pack (Neovim 0.12+)
-- Replaces lazy.nvim. Plugins are installed to $XDG_DATA_HOME/nvim/site/pack/core/opt/
-- Lockfile at $XDG_CONFIG_HOME/nvim/nvim-pack-lock.json

local gh = function(x) return "https://github.com/" .. x end

-- Disable netrw (yazi handles directories)
vim.g.loaded_netrwPlugin = 1

-------------------------------------------------------------------------------
-- Install all plugins
-------------------------------------------------------------------------------
vim.pack.add({
	-- Colorscheme (loaded first via load=true default after init)
	gh("folke/tokyonight.nvim"),

	-- Mini ecosystem
	gh("nvim-mini/mini.nvim"),

	-- Completion
	gh("saghen/blink.cmp"),
	gh("rafamadriz/friendly-snippets"),

	-- Telescope & extensions
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("olacin/telescope-cc.nvim"),

	-- Treesitter
	gh("nvim-treesitter/nvim-treesitter"),

	-- LSP
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("folke/lazydev.nvim"),
	gh("Bilal2453/luvit-meta"),

	-- Formatting
	gh("stevearc/conform.nvim"),

	-- Diagnostics
	gh("folke/trouble.nvim"),

	-- Git
	gh("NeogitOrg/neogit"),
	gh("sindrets/diffview.nvim"),
	gh("lewis6991/gitsigns.nvim"),

	-- File explorers
	gh("mikavilpas/yazi.nvim"),
	gh("stevearc/oil.nvim"),

	-- Navigation
	{ src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },

	-- Debug
	gh("mfussenegger/nvim-dap"),
	gh("rcarriga/nvim-dap-ui"),
	gh("theHamsta/nvim-dap-virtual-text"),
	gh("nvim-neotest/nvim-nio"),
	gh("mxsdev/nvim-dap-vscode-js"),

	-- UI
	gh("folke/which-key.nvim"),
	gh("Aasim-A/scrollEOF.nvim"),

	-- AI
	gh("folke/snacks.nvim"),
	gh("NickvanDyke/opencode.nvim"),
})

-------------------------------------------------------------------------------
-- Post-install build hooks
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("User", {
	pattern = "PackChanged",
	callback = function()
		local fzf_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt", "telescope-fzf-native.nvim")
		if vim.uv.fs_stat(fzf_dir) then
			vim.system({ "make" }, { cwd = fzf_dir }, function(result)
				if result.code == 0 then
					vim.schedule(function() vim.notify("telescope-fzf-native: built successfully") end)
				else
					vim.schedule(function() vim.notify("telescope-fzf-native: build failed\n" .. (result.stderr or ""), vim.log.levels.ERROR) end)
				end
			end)
		end
	end,
})

-------------------------------------------------------------------------------
-- Plugin configuration (order matters for dependencies)
-------------------------------------------------------------------------------

-- Colorscheme ----------------------------------------------------------------
---@diagnostic disable-next-line: missing-fields
require("tokyonight").setup({
	styles = {
		comments = { italic = false },
	},
})
vim.cmd.colorscheme("tokyonight-night")

-- Mini.nvim ------------------------------------------------------------------
require("mini.ai").setup()
require("mini.cmdline").setup()
require("mini.comment").setup()
require("mini.cursorword").setup()
require("mini.icons").setup()
require("mini.jump").setup()
require("mini.move").setup()
require("mini.notify").setup()
require("mini.operators").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.starter").setup()
require("mini.statusline").setup()
require("mini.surround").setup()
require("mini.trailspace").setup()

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

-- Completion (blink.cmp) -----------------------------------------------------
require("blink.cmp").setup({
	keymap = {
		preset = "default",
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
	},
	completion = { documentation = { auto_show = false } },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	signature = { enabled = true },
	fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- Telescope ------------------------------------------------------------------
require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sc", builtin.git_status, { desc = "[S]earch [C]hanged Files" })
vim.keymap.set("n", "<leader>sb", builtin.git_branches, { desc = "[S]earch Git [B]ranches" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>s<leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

local function create_conventional_commit()
	local actions = require("telescope._extensions.conventional_commits.actions")
	local picker = require("telescope._extensions.conventional_commits.picker")
	local themes = require("telescope.themes")

	local opts = {
		action = actions.prompt,
		include_body_and_footer = true,
	}
	opts = vim.tbl_extend("force", opts, themes["get_ivy"]())
	picker(opts)
end

vim.keymap.set("n", "cc", create_conventional_commit, { desc = "Create conventional commit" })

-- Treesitter -----------------------------------------------------------------
require("custom.config.treesitter").setup()

-- LSP (Mason + mason-lspconfig) ----------------------------------------------
require("lazydev").setup({
	library = {
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
})

require("mason").setup({})

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

-- Formatting (conform.nvim) --------------------------------------------------
require("conform").setup({
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
})

vim.keymap.set("", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

-- Diagnostics (trouble.nvim) -------------------------------------------------
require("trouble").setup({})

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Git ------------------------------------------------------------------------
require("neogit").setup({})
vim.keymap.set("n", "<leader>hh", "<cmd>Neogit<cr>", { desc = "Show Neogit UI" })

require("gitsigns").setup({
	current_line_blame = true,
})

-- File explorers -------------------------------------------------------------
require("yazi").setup({
	open_for_directories = true,
	keymaps = {
		show_help = "<f1>",
	},
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

-- Harpoon --------------------------------------------------------------------
local harpoon = require("harpoon")
harpoon:setup({})

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<C-S-H>", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<C-S-L>", function()
	harpoon:list():next()
end)

-- Debug (DAP) ----------------------------------------------------------------
local dap = require("dap")
local ui = require("dapui")

require("dapui").setup()
require("nvim-dap-virtual-text").setup({})

require("dap-vscode-js").setup({
	debugger_path = "/home/kennyek/dev/microsoft/vscode-js-debug",
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
})

local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
for _, language in ipairs(js_filetypes) do
	dap.configurations[language] = {}
end

if not dap.adapters["node"] then
	dap.adapters["node"] = function(cb, config)
		if config.type == "node" then
			config.type = "pwa-node"
		end
		local nativeAdapter = dap.adapters["pwa-node"]
		if type(nativeAdapter) == "function" then
			nativeAdapter(cb, config)
		else
			cb(nativeAdapter)
		end
	end
end

vim.keymap.set("n", "<space>db", dap.toggle_breakpoint, { desc = "[T]oggle breakpoint" })
vim.keymap.set("n", "<space>dg", dap.run_to_cursor, { desc = "Run to cursor" })

vim.keymap.set("n", "<space>?", function()
	require("dapui").eval(nil, { enter = true })
end, { desc = "Evaluate value" })

vim.keymap.set("n", "<space>dc", dap.continue, { desc = "[C]ontinue debugging" })
vim.keymap.set("n", "<space>di", dap.step_into, { desc = "Step [I]nto" })
vim.keymap.set("n", "<space>dn", dap.step_over, { desc = "Go to [N]ext breakpoint" })
vim.keymap.set("n", "<space>do", dap.step_out, { desc = "Step [O]ut" })
vim.keymap.set("n", "<space>dB", dap.step_back, { desc = "Step [B]ack" })
vim.keymap.set("n", "<space>dr", dap.restart, { desc = "[R]estart" })
vim.keymap.set("n", "<space>dq", dap.terminate, { desc = "[Q]uit" })

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end

-- Which Key ------------------------------------------------------------------
require("which-key").setup({
	delay = 0,
	icons = {
		mappings = vim.g.have_nerd_font,
		keys = {},
	},
	spec = {
		{ "<leader>b", group = "[B]uffer" },
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>d", group = "[D]ebug" },
		{ "<leader>e", group = "[E]xplorer" },
		{ "<leader>g", group = "[G]o to", mode = { "n", "v" } },
		{ "<leader>h", group = "Git [H]unks", mode = { "n", "v" } },
		{ "<leader>q", group = "[Q]uickfix" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>w", group = "[W]indow" },
	},
})

-- ScrollEOF ------------------------------------------------------------------
require("scrollEOF").setup({
	insert_mode = true,
	floating = false,
})

-- Snacks + OpenCode ----------------------------------------------------------
require("snacks").setup({ input = {}, picker = {}, terminal = {} })

---@type opencode.Opts
vim.g.opencode_opts = {}
vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<leader>oa", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "[O]pencode: [A]sk" })
vim.keymap.set({ "n", "x" }, "<leader>ox", function()
	require("opencode").select()
end, { desc = "[O]pencode: E[x]ecute action" })
vim.keymap.set({ "n", "t" }, "<leader>ot", function()
	require("opencode").toggle()
end, { desc = "[O]pencode: [T]oggle" })

vim.keymap.set({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<S-C-u>", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll opencode up" })
vim.keymap.set("n", "<S-C-d>", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll opencode down" })
