M = {}

function M.setup()
	vim.api.nvim_create_autocmd("BufReadPost", {
		pattern = "nook.txt",
		callback = function()
			vim.cmd("highlight NookTodo ctermfg=Yellow guifg=#FFFF00")
			vim.fn.matchadd("NookTodo", "TODO")
		end,
	})
end

return M
