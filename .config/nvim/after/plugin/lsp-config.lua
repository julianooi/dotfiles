local lsp = require("lsp-zero").preset({})

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr }
	local bind = vim.keymap.set
	local tele = require("telescope.builtin")

	local function viewReferences()
		tele.lsp_references({
			include_declaration = false,
			include_current_line = false,
		})
	end
	bind("n", "<leader><leader>r", viewReferences, opts)
	bind("n", "gr", viewReferences, { buffer = bufnr, desc = "view references" })
	bind("n", "g[", tele.lsp_incoming_calls, { buffer = bufnr, desc = "lsp incoming calls" })
	bind("n", "g]", tele.lsp_outgoing_calls, { buffer = bufnr, desc = "lsp outgoing calls" })
	bind("n", "gi", tele.lsp_implementations, { buffer = bufnr, desc = "lsp implementations" })
	bind("n", "go", "<cmd>Telescope lsp_type_definitions<cr>", { buffer = bufnr, desc = "lsp type definitions" })
	bind("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", { buffer = bufnr, desc = "lsp type definitions" })
	bind("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { buffer = bufnr, desc = "lsp go to definitions" })
	bind("n", "<C-]>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "lsp show function signature" })
	bind("i", "<C-]>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "lsp show function signature" })
	bind("n", "<leader>pl", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
	bind("n", "<leader>pL", "<cmd>Telescope lsp_document_symbols<cr>", opts)

	lsp.default_keymaps({
		buffer = bufnr,
		omit = { "gi", "go", "gr", "gd", "<C-k>", "<C-p>" },
		preserve_mappings = true,
	})

	if client.name ~= "templ" and client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = function()
				vim.lsp.buf.clear_references()
				vim.lsp.buf.document_highlight()
			end,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Clear All the References",
		})
	end

	if client.name == "gopls" then
		if not client.server_capabilities.semanticTokensProvider then
			local semantic = client.config.capabilities.textDocument.semanticTokens
			client.server_capabilities.semanticTokensProvider = {
				full = true,
				legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
				range = true,
			}
		end
	end
end

local client_capabilities = {
	workspace = {
		didChangeWatchedFiles = {
			dynamicRegistration = true,
		},
	},
}
require("mason").setup({})
require("mason-lspconfig").setup({
	handlers = {
		lsp.default_setup,
		emmet_language_server = function()
			require("lspconfig").emmet_language_server.setup({
				filetypes = { "html", "gohtml", "templ" },
			})
		end,
		html = function()
			require("lspconfig").html.setup({
				filetypes = { "html", "gohtml", "templ" },
			})
		end,
		volar = function()
			require("lspconfig").volar.setup({})
		end,
		ts_ls = function()
			local mason_registry = require("mason-registry")
			local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
				.. "/node_modules/@vue/language-server"
			require("lspconfig").ts_ls.setup({
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})
		end,
		yamlls = function()
			require("lspconfig").yamlls.setup({
				settings = {
					yaml = {
						keyOrdering = false,
					},
				},
			})
		end,
		gopls = function()
			require("lspconfig").gopls.setup({
				filetypes = { "go", "gohtml", "html", "gomod" },
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
				settings = {
					gopls = {
						semanticTokens = true,
						gofumpt = true,
						templateExtensions = { "gohtml" },
						-- hints = {
						-- 	assignVariableTypes = true,
						-- 	compositeLiteralFields = true,
						-- 	compositeLiteralTypes = true,
						-- 	constantValues = true,
						-- 	functionTypeParameters = true,
						-- 	parameterNames = true,
						-- 	rangeVariableTypes = true,
						-- },
					},
				},
			})
		end,
		golangci_lint_ls = function()
			require("lspconfig").golangci_lint_ls.setup({
				capabilities = client_capabilities,
				filetypes = { "go", "gomod" },
				-- on_init = function(client)
				-- 	return false
				-- end,
			})
		end,
		terraformls = function()
			require("lspconfig").terraformls.setup({
				filetypes = { "tf", "terraform" },
			})
		end,
		lua_ls = function()
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
		end,
		templ = function()
			require("lspconfig").templ.setup({
				capabilities = client_capabilities,
				filetypes = { "templ" },
			})
		end,
		tailwindcss = function()
			require("lspconfig").tailwindcss.setup({
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
				filetypes = {
					"templ",
					"gohtml",
				},
				init_options = {
					userLanguages = {
						templ = "html",
					},
				},
			})
		end,
		elixirls = function()
			require("lspconfig").elixirls.setup({
				capabilities = client_capabilities,
				filetypes = { "elixir", "eelixir", "exs" },
			})
		end,
	},
})

require("lspconfig").gdscript.setup({
	filetypes = { "gd", "gdscript", "gdscript3" },
})
lsp.extend_cmp({
	set_mapping = true,
	set_basic_mapping = true,
	set_extra_mappings = true,
	documentation_window = true,
})
require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
cmp.setup({
	mapping = {
		["<C-p>"] = cmp_action.select_prev_or_fallback(),
		-- Scroll up and down in the completion documentation
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
	},
	sources = {
		{ name = "nvim_lsp", group_index = 1, priority = 9 },
		{ name = "luasnip", group_index = 1, priority = 0 },
		{ name = "buffer", group_index = 10 },
		{ name = "vim-dadbod-completion" },
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})

lsp.on_attach(on_attach)
lsp.setup()

-- Flutter setupfunction()
require("flutter-tools").setup({
	widget_guides = {
		enabled = true,
	},
	lsp = {
		color = {
			enabled = true,
		},
		on_attach = on_attach,
	},
})
require("telescope").load_extension("flutter")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		-- buf_request_sync defaults to a 1000ms timeout. Depending on your
		-- machine and codebase, you may want longer. Add an additional
		-- argument after params if you find that you have to write the file
		-- twice for changes to be saved.
		-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end,
})
