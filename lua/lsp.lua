vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	-- Specific settings to send to the server. The schema is server-defined.
	-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			}
		}
	}
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

		vim.keymap.set('n', 'gD',  vim.lsp.buf.declaration, { buffer = ev.buf, desc = 'LSP: Goto [D]eclaration' })

		-- local builtin = require 'telescope.builtin'

		-- vim.keymap.set('n', 'grr', builtin.lsp_references , { buffer = ev.buf, desc = 'LSP: Goto [R]eferences')
		-- vim.keymap.set('n', 'gd',  builtin.lsp_definitions, { buffer = ev.buf, desc = 'LSP: Goto [D]efinitions')

		-- Inlay hint toggling
		if client:supports_method('textDocument/inlayHint', ev.buf) then
			vim.lsp.inlay_hint.enable( true )
			vim.keymap.set('n', '<leader>i', function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf })
			end, { buffer = ev.buf, desc = 'LSP: Toggle [I]nlay [H]ints' })
		end

	end,
})


vim.lsp.enable('lua_ls')
