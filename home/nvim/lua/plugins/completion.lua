require('mini.completion').setup()

-- <CR> confirms selection; falls through to a normal newline if no popup
vim.keymap.set('i', '<CR>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { expr = true })
