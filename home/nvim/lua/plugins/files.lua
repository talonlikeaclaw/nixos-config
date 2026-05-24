require('mini.files').setup({
  windows = {
    preview = true,
    width_focus = 40,
    width_preview = 60,
  },
})

-- Toggle explorer at cwd, or at current file's directory
local toggle = function(at_file)
  if not MiniFiles.close() then
    if at_file then
      MiniFiles.open(vim.api.nvim_buf_get_name(0))
    else
      MiniFiles.open()
    end
  end
end

vim.keymap.set('n', '<leader>e',  function() toggle(false) end, { desc = 'File explorer (cwd)' })
vim.keymap.set('n', '<leader>E',  function() toggle(true) end,  { desc = 'File explorer (current file)' })
