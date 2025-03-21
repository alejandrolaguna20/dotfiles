local M = {}

function M.open_file()
	vim.cmd("edit " .. NookFile)
end

function M.setup()
	vim.api.nvim_create_user_command("Nook", M.open_file, {})
end

return M
