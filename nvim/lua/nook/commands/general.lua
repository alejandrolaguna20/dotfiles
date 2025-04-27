local M = {}

function M.open_file()
	vim.cmd("edit " .. NookFile)
	vim.cmd("setlocal filetype=nook")
end

function M.setup()
	vim.api.nvim_create_user_command("Nook", M.open_file, {})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "nook",
		callback = function()
			require("nook.highlight").setup()
		end,
	})
end

return M
