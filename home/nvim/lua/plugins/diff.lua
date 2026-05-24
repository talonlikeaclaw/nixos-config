require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = { add = '▎', change = '▎', delete = '' },
  },
})

-- Toggle inline diff overlay (shows full +/- lines for the current hunk)
vim.keymap.set('n', '<leader>go', MiniDiff.toggle_overlay, { desc = 'Toggle diff overlay' })
