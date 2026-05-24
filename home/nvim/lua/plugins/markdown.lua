require('render-markdown').setup({
  render_modes = { 'n', 'c' }, -- render in normal + command mode (not insert, so typing feels natural)
  file_types = { 'markdown' },
})
