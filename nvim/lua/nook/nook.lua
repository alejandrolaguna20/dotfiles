-- nook.lua (in ~/.config/nvim/lua/nook/)
local M = {}

-- Function to print a status message
function M.nook_status()
	print("Nook plugin is loaded and working!")
end

-- Function to set up Nook
function M.setup()
	-- Register the custom NookStatus command
	vim.api.nvim_create_user_command("NookStatus", M.nook_status, {})
end

return M -- Make sure to return the module
