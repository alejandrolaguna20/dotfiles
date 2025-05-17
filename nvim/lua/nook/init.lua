local M = {}

local task_types = {
	TODO = "NookTodo", -- Tasks to be done
	DONE = "NookDone", -- Completed tasks
	STRT = "NookStart", -- Started tasks
	FAIL = "NookFail", -- Cancelled tasks
	LOOP = "NookLoop", -- Date markers
	WAIT = "NookWait", -- Waiting on something
	IDEA = "NookIdea", -- Ideas
}

function M.setup_highlighting()
	local highlight_groups = {
		NookTodo = { link = "String" },
		NookDone = { link = "DiffAdd" }, -- Usually green
		NookStart = { link = "Directory" }, -- Usually yellow/gold
		NookFail = { link = "ErrorMsg" }, -- Usually red
		NookLoop = { link = "SpecialChar" }, -- Usually purple
		NookWait = { link = "Comment" }, -- Usually gray
		NookIdea = { link = "VertSplit" }, -- Usually blue/cyan
	}

	for group, attrs in pairs(highlight_groups) do
		vim.api.nvim_set_hl(0, group, attrs)
	end
end

function M.setup_syntax()
	for task, hl_group in pairs(task_types) do
		vim.cmd(string.format([[syntax match %s /^\s*%s\s.*$/]], hl_group, task))
		vim.cmd(string.format([[syntax match %s /^\s\+%s\s.*$/]], hl_group, task))
	end

	vim.cmd([[syntax match NookDone /^\s*DONE\s\[.*\].*$/]]) -- Completed with date
	vim.cmd([[syntax match NookHeader /^#.*$/]]) -- Headers
end

-- Enable automatic syntax for nook.txt
function M.setup_autocmds()
	local augroup = vim.api.nvim_create_augroup("NookTaskManager", { clear = true })

	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = { "nook.txt" },
		callback = function()
			vim.bo.filetype = "nook"

			M.setup_highlighting()
			M.setup_syntax()
		end,
		group = augroup,
	})
end

function M.setup_mappings()
	vim.keymap.set("n", "<leader>nt", function()
		M.toggle_task_status()
	end, { desc = "Toggle task status", buffer = true })

	vim.keymap.set("n", "<leader>nf", function()
		M.mark_task("FAIL")
	end, { desc = "Mark task as killed", buffer = true })

	vim.keymap.set("n", "<leader>na", function()
		M.add_task()
	end, { desc = "Add new task", buffer = true })

	vim.keymap.set("n", "<leader>nd", function()
		M.add_completion_date()
	end, { desc = "Add completion date", buffer = true })
end

function M.toggle_task_status()
	local line = vim.api.nvim_get_current_line()
	local new_line = line

	if line:match("^%s*TODO") then
		new_line = line:gsub("^(%s*)TODO", "%1STRT")
	elseif line:match("^%s*STRT") then
		new_line = line:gsub("^(%s*)STRT", "%1DONE")
	elseif line:match("^%s*DONE") then
		new_line = line:gsub("^(%s*)DONE", "%1TODO")
	elseif line:match("^%s*FAIL") then
		new_line = line:gsub("^(%s*)FAIL", "%1TODO")
	else
		new_line = "TODO " .. line
	end

	vim.api.nvim_set_current_line(new_line)
end

function M.mark_task(task_type)
	local line = vim.api.nvim_get_current_line()
	local new_line = line

	if line:match("^%s*[A-Z][A-Z][A-Z][A-Z]%s") then
		new_line = line:gsub("^(%s*)[A-Z][A-Z][A-Z][A-Z]", "%1" .. task_type)
	else
		new_line = task_type .. " " .. line
	end

	vim.api.nvim_set_current_line(new_line)
end

function M.add_task()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, current_line, current_line, false, { "TODO " })
	vim.api.nvim_win_set_cursor(0, { current_line + 1, 5 })
	vim.cmd("startinsert")
end

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

function M.open_nook()
	local nook_path = vim.fn.expand("~/nook.txt")
	vim.cmd("edit " .. nook_path)
end

function M.setup(opts)
	opts = opts or {}

	M.setup_autocmds()

	vim.api.nvim_create_user_command("Nook", function()
		M.open_nook()
	end, {})

	if vim.fn.expand("%:t") == "nook.txt" then
		M.setup_highlighting()
		M.setup_syntax()
		M.setup_mappings()
	end
end

return M
