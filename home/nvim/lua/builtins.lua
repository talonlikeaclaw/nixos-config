vim.cmd.packadd('cfilter')       -- :Cfilter/:Lfilter to narrow quickfix/location lists
vim.cmd.packadd('nohlsearch')    -- auto-clear search highlight when cursor moves
vim.cmd.packadd('nvim.undotree') -- built-in undo history browser (Neovim 0.12+)

vim.keymap.set('n', '<leader>u', require('undotree').open, { desc = 'Undo tree' })
