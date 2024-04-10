local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	highlight = {
		enable = true, -- false will disable the whole extension
	},
  ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "go", "java", "bash", "xml", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
	autopairs = {
		enable = true,
	},
	indent = { enable = true, },
})
