vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Forcefully stop treesitter for markdown to prevent crashes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function(args)
		pcall(vim.treesitter.stop, args.buf)
	end,
})

local function pdf_of(file)
	return vim.fn.fnamemodify(file, ":r") .. ".pdf"
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	pattern = "*.typ",
	callback = function()
		local file = vim.fn.expand("%:p")
		local pdf = pdf_of(file)

		vim.fn.jobstart({
			"typst",
			"compile",
			file,
			pdf,
		}, { detach = true })

		vim.fn.jobstart({
			"sioyek",
			pdf,
		}, { detach = true })
	end,
})
