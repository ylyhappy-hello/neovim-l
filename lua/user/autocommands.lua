-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
-- some useful autocmd

-- while leave insert mode change input method to en
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = { "*" },
  callback = function()
    local input_status = tonumber(vim.fn.system({ "fcitx5-remote" }))
    if input_status == 2 then
      vim.fn.system("fcitx5-remote -c")
    end
  end,
})
-- detect filetype use diff tab spaces
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "java", "xml" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4

    vim.cmd("NvimTreeResize 50");
  end,
})


