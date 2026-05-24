require('mini.jump2d').setup({
  view = {
    dim = true,          -- dim non-jump lines for focus
    n_steps_ahead = 1,   -- show next step labels ahead of time
  },
  mappings = {
    start_jumping = '<CR>',
  },
})
