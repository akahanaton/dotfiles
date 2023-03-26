-- for ~/.config/lvim/config.lua
--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.colorcolumn = "90"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 200
vim.o.foldcolumn = "auto" -- make folds visible left of the sign column. Very cool ui feature!
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.swapfile = true -- creates a swapfile
--set global swap file directory to enable tmux searching: findvim.sh
vim.cmd("set directory=$HOME/.vim/swapfiles ")

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	pattern = "*",
	timeout = 1000,
}

lvim.reload_config_on_save = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- switch buffers
lvim.keys.normal_mode["<leader>j"] = ":bprevious<cr>"
lvim.keys.normal_mode["<leader>k"] = ":bnext<cr>"
-- lvim.keys.normal_mode["<leader>bq"] = ":bp <BAR> bd #<cr>"
--" no copy delete, no copy change
lvim.builtin.which_key.mappings.T = nil
lvim.builtin.which_key.mappings.d = nil -- disable which-key default mappings
lvim.keys.normal_mode["<leader>d"] = '"_d'
lvim.keys.normal_mode["<leader>C"] = '"_C'
lvim.keys.visual_mode["<leader>d"] = '"_d'
lvim.keys.visual_mode["<leader>C"] = '"_C'
lvim.keys.normal_mode["<leader>r"] = ":%s//g<LEFT><LEFT>"
lvim.keys.visual_mode["<leader>r"] = ":s//g<LEFT><LEFT>"
lvim.keys.normal_mode["vil"] = "^v$" -- select current line
lvim.keys.normal_mode["E"] = "d^" --delete to the begining of the line
lvim.keys.normal_mode["T"] = "y$" -- Yank from the cursor to the end of the line
lvim.keys.visual_mode["//"] = 'y/<C-R>"<CR>' --search selected text as a re
lvim.keys.normal_mode["<backspace>"] = "<<" -- Yank from the cursor to the end of the line
lvim.keys.visual_mode["<backspace>"] = "<gv" --search selected text as a re
lvim.keys.normal_mode["_"] = ">>" -- Yank from the cursor to the end of the line
lvim.keys.visual_mode["_"] = ">gv" --search selected text as a re

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
--

lvim.builtin.which_key.mappings["x"] = {
	name = "Toggle",
	h = { "<cmd>set hlsearch!<CR>", "Toggle Highlight" },
	q = { "<cmd>call QuickFixToggle()<CR>", "Toggle Quick Fix List" },
	b = { "<cmd>GitBlameToggle<CR>", "Toggle Git Blame" },
	t = { "<cmd>Twilight<CR>", "Toggle Twilight" },
	i = { "<cmd>IndentBlanklineToggle<CR>", "Toggle Indent Line" },
	x = { "<cmd>TroubleToggle<CR>", "Toggle Trouble" },
}

lvim.builtin.which_key.mappings["/"] = {
	"<Plug>(comment_toggle_linewise_current)",
	"Comment line",
}
local ft = require("Comment.ft")
ft.set("autohotkey", ";%s")

-- vimspector
lvim.builtin.which_key.mappings["v"] = {
	name = "vimspector",
	r = { "<Plug>VimspectorRunToCursor", "Run to cursor" },
	o = { "<Plug>VimspectorStepOver", "Step over" },
	i = { "<Plug>VimspectorStepInto", "Step into" },
	t = { "<Plug>VimspectorStepOut", "Step out" },
	s = { "<Plug>VimspectorStop", "Stop" },
	c = { "<Plug>VimspectorContinue", "Continue" },
	b = { "<Plug>VimspectorBreakpoints", "Breakpoints window" },
	a = { "<Plug>VimspectorAddFunctionBreakpoint", "Add function breakpoint" },
	q = { ":VimspectorReset<CR>", "Reset" },
}

-- symbols-outline
lvim.builtin.which_key.mappings["m"] = {
	name = "symbols outline",
	m = { ":SymbolsOutlineOpen<CR>", "Open" },
	q = { ":SymbolsOutlineClose<CR>", "Close" },
}

-- Telescope
-- Change  navigation to use j and k for navigation
-- and n and p for history in both input and normal mode.
lvim.builtin.telescope.on_config_done = function()
	local actions = require("telescope.actions")
	-- for input mode
	lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
	lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
	lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
	lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
	-- for normal mode
	lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
	lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
end
lvim.builtin.telescope.defaults.vimgrep_arguments = {
	"rg",
	"--no-heading",
	"--with-filename",
	"--line-number",
	"--column",
	"--smart-case",
	"-u", -- include .gitignore files
}
lvim.builtin.telescope.pickers.find_files = { no_ignore = true } -- include .gitignore files
lvim.builtin.telescope.defaults.file_ignore_patterns = {
	"%.log",
	"vendor/*",
	"%.lock",
	"%.ipynb",
	"%.jpg",
	"%.jpeg",
	"%.png",
	"%.svg",
	"%.otf",
	"%.ttf",
	".git/",
	".dart_tool/",
	".github/",
	".gradle/",
	".vscode/",
	"__pycache__/",
	"__pycache__/*",
	"build/",
	"env/",
	"gradle/",
	"node_modules/",
	"node_modules/*",
	"target/",
	"%.pdb",
	"%.dll",
	"%.class",
	"%.exe",
	"%.cache",
	"%.ico",
	"%.pdf",
	"%.dylib",
	"%.jar",
	"%.docx",
	"%.met",
	"smalljre_*/*",
	".vale/",
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.breadcrumbs.active = false -- disable nvim-navic, not work, need uninstall it from source

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- Automatically select the first item in the completion list
lvim.builtin.cmp.completion.completeopt = "menu,menuone"

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`

-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
lvim.lsp.installer.setup.automatic_installation = false
require("lvim.lsp.manager").setup("pylsp", {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					-- ignore = { "W391" },
					-- maxLineLength = 80,
					enabled = false,
				},
			},
		},
	},
})
-- require("lspconfig").csharp_ls.setup({}) -- for c#, not work

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua" },
	{
		command = "prettier",
		extra_args = { "--print-with", "100" },
		filetypes = { "typescript", "typescriptreact" },
	},
	{ command = "yapf", filetypes = { "python" } },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "flake8", filetypes = { "python" } },
	{
		command = "shellcheck",
		args = { "--severity", "warning" },
	},
})

-- -- Autocommands () <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

--automatically reload tmux config after editing
vim.api.nvim_create_autocmd("bufwritepost", {
	pattern = { ".tmux.conf" },
	command = "!tmux source-file ~/.tmux.conf",
})
--automatically reload kitty config after editing
vim.api.nvim_create_autocmd("bufwritepost", {
	pattern = { "kitty.conf" },
	command = "!kill -s USR1 $(pgrep -a kitty | head -1)",
})

vim.api.nvim_create_user_command("LuaSnipEdit", "lua require('luasnip.loaders').edit_snippet_files()", {})

-- lualine
lvim.builtin.lualine.style = "default"
-- lvim.builtin.lualine.options.globalstatus = true -- only works with neovim-nightly
-- -- Change theme settings
lvim.colorscheme = "tokyonight-night"

local components = require("lvim.core.lualine.components")

-- make a few changes to the lualine lsp component
local lsp_component = components.lsp
lsp_component.icon = { "", color = { fg = require("lvim.core.lualine.colors").blue } }
-- no longer needed with full width statusbar
-- lsp_component.cond = function () return vim.fn.winwidth(0) > 80 end
lsp_component.color = {
	gui = "None", --[[, fg = require"lvim.core.lualine.colors".blue]]
}

-- match icons with the ones in the signs column
local diagnostics_component = components.diagnostics
diagnostics_component.symbols.error = " "
diagnostics_component.symbols.warn = " "
diagnostics_component.symbols.info = " "
diagnostics_component.symbols.hint = " "

-- remove null_ls, adjust formatting
---@param message string
---@return string
lsp_component[1] = function(message)
	local buf_clients = vim.lsp.get_active_clients()
	if next(buf_clients) == nil then
		if type(message) == "boolean" or #message == 0 then
			return ""
		end
		return message
	end
	local buf_client_names = {}
	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end
	-- no longer needed with full width statusbar
	-- if vim.fn.winwidth(0) < 150 and #(buf_client_names) > 1 then return #(buf_client_names) end
	local first_few = vim.list_slice(buf_client_names, 1, 2)
	local extra_count = #buf_client_names - 2
	local output = table.concat(first_few, ", ")
	if extra_count > 0 then
		output = output .. " +" .. extra_count
	end
	return output
end
-- remove extra padding around tree
---@return string
local display_treesitter_status = function()
	local b = vim.api.nvim_get_current_buf()
	if next(vim.treesitter.highlighter.active[b]) then
		return ""
	end
	return ""
end

lvim.builtin.lualine.options = {
	component_separators = "|",
	section_separators = { left = "", right = "" },
}

lvim.builtin.lualine.sections.lualine_a = {
	{ "mode", separator = { left = "" }, right_padding = 2 },
}

lvim.builtin.lualine.sections.lualine_b = {
	"branch",
	{ "diagnostics", source = { "nvim" }, sections = { "error" } },
	{ "diagnostics", source = { "nvim" }, sections = { "warn" } },
	{ "filename", file_status = false, path = 1 },
	{
		"%w",
		cond = function()
			return vim.wo.previewwindow
		end,
	},
	{
		"%r",
		cond = function()
			return vim.bo.readonly
		end,
	},
	{
		"%q",
		cond = function()
			return vim.bo.buftype == "quickfix"
		end,
	},
}

lvim.builtin.lualine.sections.lualine_c = {
	"diff",
	{ "diagnostics", source = { "nvim" }, sections = { "error" } },
	{ "diagnostics", source = { "nvim" }, sections = { "warn" } },
	{
		"%w",
		cond = function()
			return vim.wo.previewwindow
		end,
	},
	{
		"%r",
		cond = function()
			return vim.bo.readonly
		end,
	},
	{
		"%q",
		cond = function()
			return vim.bo.buftype == "quickfix"
		end,
	},
}

lvim.builtin.lualine.sections.lualine_x = {
	diagnostics_component,
	lsp_component,
	{
		display_treesitter_status,
		color = { fg = require("lvim.core.lualine.colors").green },
		cond = require("lvim.core.lualine.conditions").hide_in_width,
	},
	components.filetype,
}

lvim.builtin.lualine.sections.lualine_z = {
	{ "location", separator = { right = "" }, left_padding = 2 },
}
-- gd tabline, change tabline = nil to:
-- tabline = { lualine_a = nil }
lvim.builtin.lualine.tabline.lualine_a = {
	{
		"buffers",
		separator = { left = "", right = "" },
		right_padding = 2,
		symbols = { alternate_file = "" },
	},
}

-- add cmp sources
-- tmux
table.insert(lvim.builtin.cmp.sources, { name = "tmux", keyword_length = 2 })
-- cmp-dictionary
----------------------------------------------------
table.insert(lvim.builtin.cmp.sources, { name = "dictionary", keyword_length = 2 })
lvim.builtin.cmp.formatting.source_names["dictionary"] = ""
----------------------------------------------------

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
	{ "AndrewRadev/bufferize.vim" },
	{ "tpope/vim-repeat" },
	{ "puremourning/vimspector" },
	{ "andersevenrud/cmp-tmux" },
	{ "tpope/vim-surround" },
	-- { "lunarvim/colorschemes" },
	{ "tpope/vim-eunuch" },
	{ "akahanaton/vim-coloresque" },
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		config = function()
			require("trouble").setup({
				-- "workspace_diagnostics", "quickfix", "lsp_references", "loclist"
				mode = "document_diagnostics",
			})
		end,
	},
	{
		"uga-rosa/cmp-dictionary",
		before = "nvim-cmp",
		requires = "hrsh7th/nvim-cmp",
		config = function()
			require("cmp_dictionary").setup({
				dic = { ["*"] = "/Users/mingwen/linuxrcfiles/words" },
				async = true,
				document = true, -- not wrok, need change the source code
			})
		end,
	}, -- vim dictionary source for cmp
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			})
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		event = { "BufRead", "BufNew" },
		config = function()
			require("bqf").setup({
				auto_enable = true,
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
				},
				func_map = {
					vsplit = "",
					ptogglemode = "z,",
					stoggleup = "",
				},
				filter = {
					fzf = {
						action_for = { ["ctrl-s"] = "split" },
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
					},
				},
			})
		end,
	},
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
		end,
	},
	{
		"p00f/nvim-ts-rainbow",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					-- ...
				},
				-- ...
				rainbow = {
					enable = true,
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
			})
		end,
	},
}
