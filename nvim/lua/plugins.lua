-- Plugin management with lazy.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
	-- Simple plugins without extra configuration
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"junegunn/goyo.vim", -- Distraction-free mode
	"preservim/vim-markdown", -- Markdown highlighting
	"dhruvasagar/vim-table-mode", -- Tables in Markdown
	"xiyaowong/transparent.nvim",
	"jwalton512/vim-blade",
	"Bilal2453/luvit-meta",

	-- Plugins with simple inline configuration
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*", -- Apply to all files
				css = { rgb_fn = true }, -- Enable `rgb()` functions for CSS
				html = { mode = "foreground" }, -- Use foreground mode for HTML
			})
		end,
	},
	-- this is a local plugin i am developing, why doesnt it work?
	{
		dir = vim.fn.expand("~/.config/nvim/lua/nook"), -- Expanding the path correctly
		name = "nook",
		config = function()
			-- Make sure the plugin is set up when loaded
			require("nook").setup()
		end,
		lazy = false, -- Load eagerly when Neovim starts
	},

	-- Plugins with more complex configuration in separate files
	{ import = "plugins.presence" },
	{ import = "plugins.gitsigns" },
	{ import = "plugins.which_key" },
	{ import = "plugins.telescope" },
	{ import = "plugins.lazydev" },
	{ import = "plugins.lsp" },
	{ import = "plugins.conform" },
	{ import = "plugins.cmp" },
	{ import = "plugins.kanagawa" },
	{ import = "plugins.todo_comments" },
	{ import = "plugins.mini" },
	{ import = "plugins.treesitter" },
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
