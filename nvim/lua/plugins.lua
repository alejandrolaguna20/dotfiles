local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-sleuth",
	"folke/zen-mode.nvim",
	"preservim/vim-markdown",
	"dhruvasagar/vim-table-mode",
	"xiyaowong/transparent.nvim",
	"jwalton512/vim-blade",
	"Bilal2453/luvit-meta",
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
				css = { rgb_fn = true },
				html = { mode = "foreground" },
			})
		end,
	},
	{
		"NStefan002/screenkey.nvim",
		lazy = false,
		version = "*", -- or branch = "main", to use the latest commit
	},
	{ import = "plugins.presence" },
	{ import = "plugins.gitsigns" },
	{ import = "plugins.which_key" },
	{ import = "plugins.obsidian" },
	{ import = "plugins.telescope" },
	{ import = "plugins.lazydev" },
	{ import = "plugins.lsp" },
	{ import = "plugins.conform" },
	{ import = "plugins.cmp" },
	{ import = "plugins.colorscheme" },
	{ import = "plugins.todo_comments" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.startup" },
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
