return {
	"vyfor/cord.nvim",
	name = "cord",
	config = function()
		require("cord").setup({
			enabled = true,
			log_level = vim.log.levels.OFF,
			editor = {
				client = "neovim",
				tooltip = "Neovim",
				icon = nil,
			},
			display = {
				theme = "atom",
				flavor = "dark",
				swap_fields = false,
				swap_icons = false,
			},
			timestamp = {
				enabled = true,
				reset_on_idle = false,
				reset_on_change = false,
			},
			idle = {
				enabled = true,
				timeout = 300000,
				show_status = true,
				ignore_focus = true,
				unidle_on_focus = true,
				smart_idle = true,
				details = "Forgot to close the editor",
				state = nil,
				tooltip = "💤",
				icon = nil,
			},
			text = {
				default = nil,
				workspace = function(opts)
					return "in one of my repos"
				end,
				viewing = function(opts)
					return "viewing something interesting"
				end,
				editing = function(opts)
					return "editing something complicated"
				end,
				file_browser = function(opts)
					return "browsing files somewhere"
				end,
				plugin_manager = function(opts)
					return "managing my cool config"
				end,
				lsp = function(opts)
					return "configuring LSPs as can't code without them"
				end,
				docs = function(opts)
					return "reading some boring file"
				end,
				vcs = function(opts)
					return "committing changes"
				end,
				notes = function(opts)
					return "taking notes"
				end,
				debug = function(opts)
					return "debugging"
				end,
				test = function(opts)
					return "testing"
				end,
				diagnostics = function(opts)
					return "fixing problems :("
				end,
				games = function(opts)
					return "playing"
				end,
				terminal = function(opts)
					return "running commands"
				end,
				dashboard = "home",
			},
			buttons = nil,
			-- buttons = {
			--   {
			--     label = 'View Repository',
			--     url = function(opts) return opts.repo_url end,
			--   },
			-- },
			assets = nil,
			variables = nil,
			hooks = {
				ready = nil,
				shutdown = nil,
				pre_activity = nil,
				post_activity = nil,
				idle_enter = nil,
				idle_leave = nil,
				workspace_change = nil,
			},
			plugins = nil,
			advanced = {
				plugin = {
					autocmds = true,
					cursor_update = "on_hold",
					match_in_mappings = true,
				},
				server = {
					update = "fetch",
					pipe_path = nil,
					executable_path = nil,
					timeout = 300000,
				},
				discord = {
					reconnect = {
						enabled = false,
						interval = 5000,
						initial = true,
					},
				},
				workspace = {
					root_markers = {
						".git",
						".hg",
						".svn",
					},
					limit_to_cwd = false,
				},
			},
		})
	end,
}
