require('mini.sessions').setup({
  autoread = false,
  autowrite = true,
  directory = vim.fn.stdpath('data') .. '/sessions',
  file = '.session.vim',
})

vim.keymap.set('n', '<leader>ss', function()
  local name = vim.fn.input('Session name: ')
  if name ~= '' then MiniSessions.write(name) end
end, { desc = 'Save session' })

vim.keymap.set('n', '<leader>sl', function() MiniSessions.select() end, { desc = 'Load session' })
vim.keymap.set('n', '<leader>sd', function() MiniSessions.select('delete') end, { desc = 'Delete session' })
