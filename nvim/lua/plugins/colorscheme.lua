return {
	"Mofiqul/adwaita.nvim",
	lazy = false,
	priority = 1000,

	-- configure and set on startup
	config = function()
		vim.g.adwaita_darker = false -- for darker version
		vim.g.adwaita_disable_cursorline = false -- to disable cursorline
		vim.g.adwaita_transparent = false -- makes the background transparent
		vim.cmd("colorscheme adwaita")
	end,
}
