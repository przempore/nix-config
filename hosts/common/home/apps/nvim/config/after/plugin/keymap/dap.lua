local Remap = require("my_config.keymap")
local nnoremap = Remap.nnoremap

local dap = require("dap")

nnoremap("<F5>", function() dap.continue() end, { noremap = true, silent = true, desc = "[DAP] Continue" });
nnoremap("<F9>", function() dap.toggle_breakpoint() end)
nnoremap("<F10>", function() dap.step_over() end)
nnoremap("<F11>", function() dap.step_into() end)
nnoremap("<F12>", function() dap.step_out() end)
nnoremap("<leader>db", function() dap.step_out() end)
nnoremap("<Leader>b", function() dap.toggle_breakpoint() end)
nnoremap("<Leader>B", function() dap.set_breakpoint() end)
nnoremap("<Leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
nnoremap("<Leader>dr", function() dap.repl.open() end)
nnoremap("<Leader>dl", function() dap.run_last() end)

vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
