local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require "user.options"
require ("lazy").setup("user.plugins",{})
require "user.keymaps"
require "user.dap"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.alpha"
require "user.autocommands"
require "user.nvimtree"
