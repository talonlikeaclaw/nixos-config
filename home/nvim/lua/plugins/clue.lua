local miniclue = require('mini.clue')

miniclue.setup({
  window = { delay = 200 },
  triggers = {
    { mode = { 'n', 'x' }, keys = '<Leader>' },
    { mode = { 'n', 'x' }, keys = 'g' },
    { mode = 'n',           keys = '[' },
    { mode = 'n',           keys = ']' },
    { mode = 'n',           keys = '<C-w>' },
    { mode = { 'n', 'x' }, keys = 'z' },
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },
    { mode = 'i',           keys = '<C-x>' },
  },
  clues = {
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
    miniclue.gen_clues.square_brackets(),
    -- Group labels
    { mode = 'n', keys = '<Leader>f', desc = '+Find/File' },
    { mode = 'n', keys = '<Leader>g', desc = '+Git' },
    { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
    { mode = 'n', keys = '<Leader>o', desc = '+Obsidian' },
    { mode = 'n', keys = '<Leader>s', desc = '+Sessions' },
    { mode = 'n', keys = '<Leader>b', desc = '+Buffers' },
    { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
    { mode = 'n', keys = '<Leader>w', desc = '+Windows' },
  },
})
