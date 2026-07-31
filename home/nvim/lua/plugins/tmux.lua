-- vim-tmux-navigator handles tmux sessions; use Herdr's integration inside Herdr.
if vim.env.HERDR_ENV ~= '1' then return end

local herdrSplits = require('herdr-splits')

herdrSplits.setup({
  resize_keys = { left = '<C-Left>', down = '<C-Down>', up = '<C-Up>', right = '<C-Right>' },
})

vim.keymap.set('n', '<C-h>', herdrSplits.move_cursor_left, { desc = 'Navigate left' })
vim.keymap.set('n', '<C-j>', herdrSplits.move_cursor_down, { desc = 'Navigate down' })
vim.keymap.set('n', '<C-k>', herdrSplits.move_cursor_up, { desc = 'Navigate up' })
vim.keymap.set('n', '<C-l>', herdrSplits.move_cursor_right, { desc = 'Navigate right' })
vim.keymap.set('n', '<C-Left>', herdrSplits.resize_left, { desc = 'Resize left' })
vim.keymap.set('n', '<C-Down>', herdrSplits.resize_down, { desc = 'Resize down' })
vim.keymap.set('n', '<C-Up>', herdrSplits.resize_up, { desc = 'Resize up' })
vim.keymap.set('n', '<C-Right>', herdrSplits.resize_right, { desc = 'Resize right' })
