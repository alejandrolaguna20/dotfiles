-- Note-taking related configuration

-- Note-taking keymaps
-- Quick Note Actions
vim.keymap.set("n", "<leader>nn", ":e ~/brain/_inbox.md<CR>") -- Open Inbox
vim.keymap.set("n", "<leader>nd", ":e ~/brain/journal/" .. os.date("%Y-%m-%d") .. ".md<CR>") -- Today's Note
vim.keymap.set("n", "<leader>ny", ":e ~/brain/journal/" .. os.date("%Y-%m-%d", os.time() - 86400) .. ".md<CR>") -- Yesterday's Note
vim.keymap.set("n", "<leader>nt", ":e ~/brain/_todo.md<CR>") -- Open TODO List

-- Search Notes
vim.keymap.set("n", "<leader>nf", ":Telescope find_files cwd=~/brain<CR>") -- Find notes
vim.keymap.set("n", "<leader>ng", ":Telescope live_grep cwd=~/brain<CR>") -- Grep notes

-- Markdown Enhancements
vim.keymap.set("n", "<leader>mp", "ggO---<CR><CR>**" .. os.date("%Y-%m-%d") .. "**<CR>---<CR><CR>") -- Insert Markdown date header
vim.keymap.set("n", "<leader>mc", ":!pandoc % -o %.pdf<CR>") -- Convert Markdown to PDF

-- Fast Log Entry
vim.keymap.set("n", "<leader>nl", ":execute 'normal! Go' | execute 'normal! i- ' .. strftime('%H:%M') .. ': '<CR>") -- Timestamped log entry

-- Git Commit & Push Notes (Sync with GitHub)
vim.keymap.set(
	"n",
	"<leader>gs",
	":!cd ~/brain && git add . && git commit -m 'auto: [" .. os.date("%Y-%m-%d:%H:%M") .. "]' && git push<CR>"
)

-- Distraction-Free Mode
vim.keymap.set("n", "<leader>zz", ":Goyo<CR>") -- Zen Mode (requires Goyo plugin)
