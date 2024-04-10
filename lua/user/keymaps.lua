local opts = { noremap = true, silent = true }


local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", ";", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Sqls Switch Database

-- keymap('n', 'sd', '<cmd>SqlsSwitchDatabase<cr>', opts)

keymap('n', 'K', '<NOP>', opts)



-- only change text
--keymap('n', 'x','"_x', opts)
--keymap('v', 'x','"_x', opts)
keymap('n', 'Y', 'y$', opts)
--keymap('v', 'c','"_c', opts)
keymap('v', 'p', 'pgvy', opts)
keymap('v', 'P', 'Pgvy', opts)
keymap('n', 'S', ':call v:lua.MagicSave()<cr>', opts)
keymap('v', 'S', ':call v:lua.MagicSave()<cr>', opts)

-- System Clipboard

keymap('v', 'cp', '"+y', opts)

-- 1 当目录不存在时 先创建目录, 2 当前文件是acwrite时, 用sudo保存
function MagicSave()
  if vim.fn.empty(vim.fn.glob(vim.fn.expand('%:p:h'))) then vim.fn.system('mkdir -p ' .. vim.fn.expand('%:p:h')) end
  if vim.o.buftype == 'acwrite' then
    vim.fn.execute('w !sudo tee > /dev/null %')
  else
    vim.fn.execute('w')
  end
end

-- Telescope
keymap('n', '<c-f>', ':Telescope current_buffer_fuzzy_find<cr>', opts)
keymap('n', '<leader>p', ':Telescope find_files<cr>', opts)
keymap('n', '<leader>hp', ':split<cr>:Telescope find_files<cr>', opts)
keymap('n', '<leader>fo', ':split<cr>:Telescope old_file<cr>', opts)
keymap('n', '<leader>vp', ':vsplit<cr>:Telescope find_files<cr>', opts)
keymap('n', '<leader>rg', ':vsplit<cr>:Telescope live_grep<cr>', opts)
keymap('n', '<leader>gb', ':Telescope git_branches<cr>', opts)
keymap('n', '<leader>fs', ':Telescope lsp_workspace_symbols<cr>', opts)
keymap('n', '<leader>fd', ':Telescope diagnostics<cr>', opts)


-- CodeRun
CODE_RUN_BUFFER = -1
CODE_RUN_WINDOW = -1
function CodeRun()
  if CODE_RUN_BUFFER == -1 then
    CODE_RUN_BUFFER = vim.api.nvim_create_buf(false, true);
  end
  local job_opts =
  {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(CODE_RUN_BUFFER, -2, -2, false, data)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(CODE_RUN_BUFFER, -2, -2, false, data)
      end
    end,
  }
  if CODE_RUN_BUFFER ~= -1 then
    vim.fn.jobstart("cmake --build build -j 8 && ./build/SocketClient", job_opts)

    if CODE_RUN_WINDOW == -1 then
      CODE_RUN_WINDOW = vim.api.nvim_open_win(CODE_RUN_BUFFER, 0,
        {
          width = 120,
          height = 12,
          relative = "editor",
          col = 0,
          border = "solid",
          style = "minimal",
          row = 35,
          title =
          "CodeRun",
          title_pos = "center"
        })
    end
  end
end

function CodeRunClose()
  if CODE_RUN_WINDOW ~= -1 then
    if pcall(vim.api.nvim_win_close, CODE_RUN_WINDOW, true) then
      CODE_RUN_WINDOW = -1
    else
      CODE_RUN_WINDOW = -1
    end
  end
end

keymap('n', '<space>r', ":call v:lua.CodeRun()<cr>", opts)
keymap('n', '<space>t', ":call v:lua.CodeRunClose()<cr>", opts)

-- NeovimTree
keymap('n', '<leader>e', ':NvimTreeFocus<cr>', opts)


-- lsp keymap
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
