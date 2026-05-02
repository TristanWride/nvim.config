require "options"

vim.pack.add({
	{ src = "https://github.com/folke/lazy.nvim.git", version = "main" },
})

require( "lazy" ).setup({ spec = { { import = "plugins" }, }, })

require "lsp"
