local M = {}

function M.setup()
	vim.api.nvim_create_user_command("NookHello", function()
		print("Hello from Nook!")
	end, {})

	print("Nook is loaded!")
end

return M
