M = {}

NookFile = vim.fn.expand("~") .. "/nook.txt"

function M.setup()
	local file_path = NookFile
	local file = io.open(file_path, "r") -- check if exists

	if not file then
		file = io.open(file_path, "w") -- create file
		if not file then
			return
		end
	end
	file:close()
end

return M
