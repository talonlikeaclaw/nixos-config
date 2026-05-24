require('mini.notify').setup({
  lsp_progress = { enable = true, duration_last = 1000 },
  window = {
    config = function()
      local has_statusline = vim.o.laststatus > 0
      local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
      return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
    end,
    winblend = 25,
  },
})

-- Replace vim.notify so all plugins use mini.notify
vim.notify = MiniNotify.make_notify()
