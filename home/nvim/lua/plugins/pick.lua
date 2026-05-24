require('mini.pick').setup({
  mappings = {
    choose_in_vsplit = '<C-j>',
    choose_in_split  = '<C-k>',
  },
})

local pick  = MiniPick.builtin
local extra = require('mini.extra').pickers

-- Files / text
vim.keymap.set('n', '<leader>ff', pick.files,                                              { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', pick.grep_live,                                          { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', pick.buffers,                                            { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', pick.help,                                               { desc = 'Help tags' })
vim.keymap.set('n', '<leader>fr', pick.resume,                                             { desc = 'Resume last picker' })
vim.keymap.set('n', '<leader>fk', extra.keymaps,                                           { desc = 'Keymaps' })
-- LSP
vim.keymap.set('n', '<leader>fs', function() extra.lsp({ scope = 'document_symbol' }) end, { desc = 'LSP symbols (buffer)' })
vim.keymap.set('n', '<leader>fS', function() extra.lsp({ scope = 'workspace_symbol' }) end, { desc = 'LSP symbols (workspace)' })
vim.keymap.set('n', '<leader>fd', function() extra.diagnostic({ scope = 'current' }) end,  { desc = 'Diagnostics (buffer)' })
vim.keymap.set('n', '<leader>fD', function() extra.diagnostic() end,                        { desc = 'Diagnostics (all)' })
-- Git
vim.keymap.set('n', '<leader>gc', extra.git_commits,                                        { desc = 'Git commits' })
vim.keymap.set('n', '<leader>gB', extra.git_branches,                                       { desc = 'Git branches' })
