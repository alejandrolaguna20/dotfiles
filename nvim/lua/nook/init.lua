local M = {}

M.commands = require("nook.commands")
M.file = require("nook.file")
M.highlight = require("nook.highlight")

function M.setup()
	M.file.setup()
	M.highlight.setup()
	M.commands.setup()
end

return M
