-- Escape insert mode without reaching for Esc
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape insert mode' })

-- Splits
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split vertical' })
vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = 'Split horizontal' })
vim.keymap.set('n', '<leader>wc', '<C-w>c', { desc = 'Close split' })
vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = 'Close others' })
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Equalize splits' })

-- Save / quit
vim.keymap.set('n', '<leader>fs', '<cmd>w<CR>',   { desc = 'Save file' })
vim.keymap.set('n', '<leader>fS', '<cmd>wa<CR>',  { desc = 'Save all files' })
vim.keymap.set('n', '<leader>q',  '<cmd>q<CR>',   { desc = 'Quit' })
vim.keymap.set('n', '<leader>Q',  '<cmd>qa!<CR>', { desc = 'Quit all' })

-- Clear search highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights' })

-- Better line navigation (wrapped lines)
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Down' })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Up' })

-- Stay centered when jumping
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })
vim.keymap.set('n', 'n',     'nzzzv',   { desc = 'Next match' })
vim.keymap.set('n', 'N',     'Nzzzv',   { desc = 'Prev match' })

-- Indent and stay in visual mode
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Buffers
vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>',     { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>',  { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bD', '<cmd>bdelete!<CR>', { desc = 'Force delete buffer' })

-- Resize with arrows
vim.keymap.set('n', '<C-Up>',    '<cmd>resize +2<CR>',          { desc = 'Increase height' })
vim.keymap.set('n', '<C-Down>',  '<cmd>resize -2<CR>',          { desc = 'Decrease height' })
vim.keymap.set('n', '<C-Left>',  '<cmd>vertical resize -2<CR>', { desc = 'Decrease width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase width' })
