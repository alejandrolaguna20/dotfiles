-- Discord presence configuration
return {
	"andweeb/presence.nvim",
	opts = {
		-- General options
		auto_update = true,
		neovim_image_text = "neovim",
		main_image = "file",
		client_id = "793271441293967371",
		log_level = nil,
		debounce_timeout = 10,
		enable_line_number = false,
		blacklist = {},
		buttons = true,
		file_assets = {},
		show_time = true,

		-- Rich Presence text options
		editing_text = "editing %s",
		file_explorer_text = "browsing %s",
		git_commit_text = "committing changes",
		plugin_manager_text = "managing plugins",
		reading_text = "reading %s",
		workspace_text = "working on %s",
		line_number_text = "line %s out of %s",
	},
}
