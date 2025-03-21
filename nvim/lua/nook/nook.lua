local M = {}

function M.nook_status()
	print("Nook plugin is loaded and working!")
end

function M.setup()
	vim.api.nvim_create_user_command("NookStatus", M.nook_status, {})
end

return M
