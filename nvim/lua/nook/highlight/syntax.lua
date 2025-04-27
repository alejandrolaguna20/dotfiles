local M = {}

function M.setup()
	-- Create a new syntax group for TODO and DONE keywords
	vim.api.nvim_command("syntax keyword nookTODO TODO contained")
	vim.api.nvim_command("syntax keyword nookDONE DONE contained")
	-- Link to existing highlight groups that are typically defined in colorschemes
	vim.api.nvim_command("highlight default link nookTODO Todo") -- Most colorschemes define Todo
	vim.api.nvim_command("highlight default link nookDONE Comment") -- Link DONE to Comment highlighting
	-- Apply this highlighting to the nook file
	vim.api.nvim_command("syntax match nookLine /.*/ contains=nookTODO,nookDONE")
end

return M
