local opts = { noremap = true, }

require("dapui").setup({
  layouts = {
    {
      -- You can change the order of elements in the sidebar
      elements = {
        -- Provide IDs as strings or tables with "id" and "size" keys
        { id = "watches",     size = 0.4 },
        { id = "scopes", size = 0.4, }, 
        -- { id = "breakpoints", size = 0.25 },
        { id = "stacks",      size = 0.2 },
      },
      size = 40,
      position = "right", -- Can be "left" or "right"
    }
  }
})
require("dap-go").setup {}
require('dap-python').setup('~/.pydebug/bin/python')
require("nvim-dap-virtual-text").setup {}
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  require("nvim-tree.api").tree.close()
  dapui.open()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.after.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.api.nvim_set_keymap("n", "<F4>", ":lua require('dap').step_back()<cr>", opts)
vim.api.nvim_set_keymap("n", "<F1>", ":lua require('dap').step_over()<cr>", opts)
vim.api.nvim_set_keymap("n", "<F3>", ":lua require('dap').step_into()<cr>", opts)
vim.api.nvim_set_keymap("n", "<F2>", ":lua require('dap').step_out ()<cr>", opts)
vim.api.nvim_set_keymap("n", "<c-a>", ":lua require('dap').continue ()<cr>", opts)
vim.api.nvim_set_keymap("n", "<space>dr", ":lua require('dap').repl.open()<cr>", opts)
vim.api.nvim_set_keymap("n", "<space>b", ":lua require('dap').toggle_breakpoint()<cr>", opts)
vim.api.nvim_set_keymap("n", "<space>B", ":lua require('dap').set_breakpoint(vim.fn.input '[DAP] Condition > ')<cr>",
  opts)
vim.api.nvim_set_keymap("n", "<space>e", ":lua require('dapui').eval()<cr>", opts)
vim.api.nvim_set_keymap("n", "<space>E", ":lua require('dapui').eval(vim.fn.input '[DAP] Expression > ')", opts)
vim.api.nvim_set_keymap("n", "<space>s", ":lua require('dap-go').debug_test()<cr>", opts)

dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
}

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
}
