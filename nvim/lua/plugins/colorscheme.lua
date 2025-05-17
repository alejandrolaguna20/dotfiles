return {
	"vague2k/vague.nvim",
	name = "vague",
	config = function()
		require("vague").setup({
			transparent = false, -- don't set background
			style = {
				number = "none",
				float = "none",
				error = "bold",
				comments = "italic",
				conditionals = "none",
				functions = "bold",
				headings = "bold",
				operators = "none",
				strings = "none",
				variables = "none",

				keywords = "none",
				keyword_return = "bold",
				keywords_loop = "none",
				keywords_label = "none",
				keywords_exception = "none",

				builtin_constants = "bold",
				builtin_functions = "none",
				builtin_types = "bold",
				builtin_variables = "none",
			},
			plugins = {
				cmp = {
					match = "bold",
					match_fuzzy = "bold",
				},
				dashboard = {
					footer = "italic",
				},
				lsp = {
					diagnostic_error = "bold",
					diagnostic_hint = "none",
					diagnostic_info = "italic",
					diagnostic_warn = "bold",
				},
				neotest = {
					focused = "bold",
					adapter_name = "bold",
				},
				telescope = {
					match = "bold",
				},
			},
			colors = {
				bg = "#141415",
				fg = "#cdcdcd",
				floatBorder = "#878787",
				line = "#252530",
				comment = "#606079",
				builtin = "#b4d4cf",
				func = "#c48282",
				string = "#e8b589",
				number = "#e0a363",
				property = "#c3c3d5",
				constant = "#aeaed1",
				parameter = "#bb9dbd",
				visual = "#333738",
				error = "#df6882",
				warning = "#f3be7c",
				hint = "#7e98e8",
				operator = "#90a0b5",
				keyword = "#6e94b2",
				type = "#9bb4bc",
				search = "#405065",
				plus = "#8cb66d",
				delta = "#f3be7c",
			},
		})
		vim.cmd("colorscheme vague")
	end,
}
