return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		----------------------------------------------------------------------
		-- LSP Attach
		----------------------------------------------------------------------

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),

			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"

					vim.keymap.set(mode, keys, func, {
						buffer = event.buf,
						desc = "LSP: " .. desc,
					})
				end

				------------------------------------------------------------------
				-- Keymaps
				------------------------------------------------------------------

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				------------------------------------------------------------------
				-- Client
				------------------------------------------------------------------

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				------------------------------------------------------------------
				-- Document Highlight
				------------------------------------------------------------------

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),

						callback = function(event2)
							vim.lsp.buf.clear_references()

							vim.api.nvim_clear_autocmds({
								group = "kickstart-lsp-highlight",
								buffer = event2.buf,
							})
						end,
					})
				end

				------------------------------------------------------------------
				-- Inlay Hints
				------------------------------------------------------------------

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		----------------------------------------------------------------------
		-- Capabilities
		----------------------------------------------------------------------

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		----------------------------------------------------------------------
		-- Servers
		----------------------------------------------------------------------

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},

			texlab = {
				settings = {
					texlab = {
						build = {
							executable = "latexmk",
							args = {
								"-pdf",
								"-interaction=nonstopmode",
								"-synctex=1",
								"%f",
							},
							onSave = true,
						},

						forwardSearch = {
							executable = "zathura",
							args = {
								"--synctex-forward",
								"%l:1:%f",
								"%p",
							},
						},

						chktex = {
							onOpenAndSave = true,
							onEdit = false,
						},
					},
				},
			},

			zls = {
				settings = {
					zls = {
						zig_exe_path = "/usr/bin/zig",
					},
				},
			},

			hls = {
				filetypes = {
					"haskell",
					"lhaskell",
					"cabal",
				},

				settings = {
					haskell = {
						formattingProvider = "fourmolu",
						checkProject = true,
						diagnosticsOnChange = true,
						completionSnippetsOn = true,
						maxCompletions = 40,
					},
				},
			},
		}

		----------------------------------------------------------------------
		-- Mason
		----------------------------------------------------------------------

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers)

		vim.list_extend(ensure_installed, {
			"stylua",
			"zls",
			"haskell-language-server",
		})

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
		})

		----------------------------------------------------------------------
		-- Mason LSPConfig
		----------------------------------------------------------------------

		require("mason-lspconfig").setup({
			handlers = {
				["julials"] = function() end,

				function(server_name)
					local server = servers[server_name] or {}

					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

					-- IMPORTANT:
					-- config() defines
					-- enable() starts/attaches

					vim.lsp.config(server_name, server)
					vim.lsp.enable(server_name)
				end,
			},
		})

		----------------------------------------------------------------------
		-- Julia
		----------------------------------------------------------------------

		vim.lsp.config("julials", {
			cmd = {
				"julia",
				"--startup-file=no",
				"--history-file=no",
				"-e",
				"using LanguageServer, SymbolServer; runserver()",
			},

			filetypes = { "julia" },

			capabilities = capabilities,
		})

		vim.lsp.enable("julials")
	end,
}
