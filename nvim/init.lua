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

-- Set colorscheme
vim.cmd("colorscheme everforest")
