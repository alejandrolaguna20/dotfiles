return {
	"datsfilipe/vesper.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("vesper").setup({
			transparent = false, -- boolean: sets the background to transparent
			italics = {
				comments = true, -- boolean: italicizes comments
				keywords = false, -- boolean: italicizes keywords
				functions = false, -- boolean: italicizes functions
				strings = true, -- boolean: italicizes strings
				variables = false, -- boolean: italicizes variables
			},
			overrides = {}, -- a dictionary of group names, can be a function returning a dictionary or a table.
			palette_overrides = {},
		})
	end,
}
