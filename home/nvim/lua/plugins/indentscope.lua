require('mini.indentscope').setup({
  symbol = '╎',
  draw = {
    delay = 50,
    animation = require('mini.indentscope').gen_animation.none(),
  },
  options = {
    border = 'both',
    indent_at_cursor = true,
  },
})

-- Disable in certain buffers where it doesn't make sense
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'notify', 'undotree' },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
