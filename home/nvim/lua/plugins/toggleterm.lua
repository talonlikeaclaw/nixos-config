require('toggleterm').setup({
  direction = 'float',
  float_opts = {
    border = 'curved',
    width  = function() return math.floor(vim.o.columns * 0.9) end,
    height = function() return math.floor(vim.o.lines * 0.9) end,
  },
  on_open = function()
    vim.cmd('startinsert!')
  end,
})

local Terminal = require('toggleterm.terminal').Terminal

-- General floating terminal
local term = Terminal:new({ hidden = true })
vim.keymap.set({ 'n', 't' }, '<leader>tt', function() term:toggle() end, { desc = 'Toggle terminal' })

-- Dedicated Claude terminal
local claude = Terminal:new({
  cmd       = 'claude',
  hidden    = true,
  float_opts = {
    border = 'curved',
    width  = function() return math.floor(vim.o.columns * 0.95) end,
    height = function() return math.floor(vim.o.lines * 0.95) end,
  },
})
vim.keymap.set({ 'n', 't' }, '<leader>ta', function() claude:toggle() end, { desc = 'Toggle Claude' })

-- Exit terminal mode easily
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
