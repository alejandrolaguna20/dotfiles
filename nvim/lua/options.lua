-- Neovim options configuration

-- UI settings
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.guicursor = "n-v-i-c:block-Cursor"
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- Highlight comments in italic
vim.api.nvim_set_hl(0, "Comment", { italic = true })

-- System clipboard integration
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Editing behavior
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Special characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
