-- nook.lua - Simple task manager for nook.txt files
local M = {}

-- Task types with their highlighting groups
local task_types = {
	TODO = "NookTodo", -- Tasks to be done
	DONE = "NookDone", -- Completed tasks
	STRT = "NookStart", -- Started tasks
	KILL = "NookKill", -- Cancelled tasks
	DATE = "NookDate", -- Date markers
	WAIT = "NookWait", -- Waiting on something
	IDEA = "NookIdea", -- Ideas
	LINK = "NookLink", -- Links
}

-- Set up syntax highlighting
function M.setup_highlighting()
	local highlight_groups = {
		NookTodo = { link = "WarningMsg" }, -- Usually yellow/orange (distinct from Error)
		NookDone = { link = "String" }, -- Usually green
		NookStart = { link = "Function" }, -- Usually yellow/gold
		NookKill = { link = "Error" }, -- Usually red
		NookDate = { link = "Constant" }, -- Usually purple
		NookWait = { link = "Comment" }, -- Usually gray
		NookIdea = { link = "Type" }, -- Usually blue/cyan
		NookLink = { link = "Underlined" }, -- Underlined text
		NookHeader = { link = "Title" }, -- Usually bold
	}

	-- Create highlight groups
	for group, attrs in pairs(highlight_groups) do
		vim.api.nvim_set_hl(0, group, attrs)
	end
end

-- Define syntax patterns
function M.setup_syntax()
	-- Define syntax items for task types
	for task, hl_group in pairs(task_types) do
		vim.cmd(string.format([[syntax match %s /^\s*%s\s.*$/]], hl_group, task))
		-- Match subtasks with proper indentation
		vim.cmd(string.format([[syntax match %s /^\s\+%s\s.*$/]], hl_group, task))
	end

	-- Additional syntax for common patterns
	vim.cmd([[syntax match NookDone /^\s*DONE\s\[.*\].*$/]]) -- Completed with date
	vim.cmd([[syntax match NookHeader /^#.*$/]]) -- Headers
end

-- Enable automatic syntax for nook.txt
function M.setup_autocmds()
	local augroup = vim.api.nvim_create_augroup("NookTaskManager", { clear = true })

	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = { "nook.txt" },
		callback = function()
			-- Set filetype
			vim.bo.filetype = "nook"

			-- Apply syntax
			M.setup_highlighting()
			M.setup_syntax()
		end,
		group = augroup,
	})
end

-- Key mappings for task management
function M.setup_mappings()
	-- Toggle task status (TODO -> STRT -> DONE)
	vim.keymap.set("n", "<leader>nt", function()
		M.toggle_task_status()
	end, { desc = "Toggle task status", buffer = true })

	-- Mark task as killed
	vim.keymap.set("n", "<leader>nk", function()
		M.mark_task("KILL")
	end, { desc = "Mark task as killed", buffer = true })

	-- Add new task
	vim.keymap.set("n", "<leader>na", function()
		M.add_task()
	end, { desc = "Add new task", buffer = true })

	-- Add completion date to DONE tasks
	vim.keymap.set("n", "<leader>nd", function()
		M.add_completion_date()
	end, { desc = "Add completion date", buffer = true })
end

-- Function to toggle task status
function M.toggle_task_status()
	local line = vim.api.nvim_get_current_line()
	local new_line = line

	if line:match("^%s*TODO") then
		new_line = line:gsub("^(%s*)TODO", "%1STRT")
	elseif line:match("^%s*STRT") then
		new_line = line:gsub("^(%s*)STRT", "%1DONE")
	elseif line:match("^%s*DONE") then
		new_line = line:gsub("^(%s*)DONE", "%1TODO")
	elseif line:match("^%s*KILL") then
		new_line = line:gsub("^(%s*)KILL", "%1TODO")
	else
		-- If no task type found, add TODO
		new_line = "TODO " .. line
	end

	vim.api.nvim_set_current_line(new_line)
end

-- Mark current task with specific type
function M.mark_task(task_type)
	local line = vim.api.nvim_get_current_line()
	local new_line = line

	-- Replace existing task type or add new one
	if line:match("^%s*[A-Z][A-Z][A-Z][A-Z]%s") then
		new_line = line:gsub("^(%s*)[A-Z][A-Z][A-Z][A-Z]", "%1" .. task_type)
	else
		new_line = task_type .. " " .. line
	end

	vim.api.nvim_set_current_line(new_line)
end

-- Add new task
function M.add_task()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, current_line, current_line, false, { "TODO " })
	vim.api.nvim_win_set_cursor(0, { current_line + 1, 5 })
	vim.cmd("startinsert")
end

-- Add completion date to DONE tasks
function M.add_completion_date()
	local line = vim.api.nvim_get_current_line()
	if line:match("^%s*DONE") then
		local date_str = os.date("[%Y-%m-%d]")

		if not line:match("%[%d%d%d%d%-%d%d%-%d%d%]") then
			local new_line = line:gsub("^(%s*DONE)%s", "%1 " .. date_str .. " ")
			vim.api.nvim_set_current_line(new_line)
		end
	end
end

-- Open nook.txt file
function M.open_nook()
	local nook_path = vim.fn.expand("~/nook.txt")
	vim.cmd("edit " .. nook_path)
end

-- Initialize plugin
function M.setup(opts)
	opts = opts or {}

	-- Set up autocommands
	M.setup_autocmds()

	-- Add user command
	vim.api.nvim_create_user_command("Nook", function()
		M.open_nook()
	end, {})

	-- Set up highlighting and syntax when buffer is loaded
	if vim.fn.expand("%:t") == "nook.txt" then
		M.setup_highlighting()
		M.setup_syntax()
		M.setup_mappings()
	end
end

return M
