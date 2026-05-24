local vault = vim.fn.expand('~/Documents/Obsidian/TalonsBrain')
if vim.fn.isdirectory(vault) == 0 then return end

require('obsidian').setup({
  workspaces = {
    { name = 'TalonsBrain', path = vim.fn.expand('~/Documents/Obsidian/TalonsBrain') },
  },

  picker = { name = 'mini.pick' },
  legacy_commands = false,
  link = {
    wiki = function(opts)
      return string.format('[[%s]]', opts.label)
    end,
  },

  -- Use render-markdown.nvim for rendering (already configured)
  ui = { enable = false },
})

-- Keymaps (only active in vault files)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local path = vim.api.nvim_buf_get_name(buf)
    if not path:find(vault, 1, true) then return end

    local opts = { buffer = buf }
    vim.keymap.set('n', '<leader>on', '<cmd>Obsidian new<CR>',          vim.tbl_extend('force', opts, { desc = 'New note' }))
    vim.keymap.set('n', '<leader>oo', '<cmd>Obsidian open<CR>',         vim.tbl_extend('force', opts, { desc = 'Open in app' }))
    vim.keymap.set('n', '<leader>os', '<cmd>Obsidian search<CR>',       vim.tbl_extend('force', opts, { desc = 'Search notes' }))
    vim.keymap.set('n', '<leader>of', '<cmd>Obsidian follow_link<CR>',  vim.tbl_extend('force', opts, { desc = 'Follow link' }))
    vim.keymap.set('n', '<leader>ob', '<cmd>Obsidian backlinks<CR>',    vim.tbl_extend('force', opts, { desc = 'Backlinks' }))
    vim.keymap.set('n', '<leader>ot', '<cmd>Obsidian tags<CR>',         vim.tbl_extend('force', opts, { desc = 'Tags' }))
    vim.keymap.set('n', '<leader>od', '<cmd>Obsidian today<CR>',        vim.tbl_extend('force', opts, { desc = "Today's daily note" }))
    vim.keymap.set('n', '<leader>ol', '<cmd>Obsidian links<CR>',        vim.tbl_extend('force', opts, { desc = 'Links in note' }))
    vim.keymap.set('v', '<leader>ol', '<cmd>Obsidian link<CR>',         vim.tbl_extend('force', opts, { desc = 'Link selection' }))
  end,
})
