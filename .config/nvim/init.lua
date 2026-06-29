-- Main entry point for Neovim configuration
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = false

-- Load core modules
require("options")
require("keymaps")
require("autocmds")
require("plugins")
require("notes")

vim.cmd("let g:falcon_background = 0")
vim.cmd("let g:falcon_inactive = 1")
vim.cmd("colorscheme falcon")
