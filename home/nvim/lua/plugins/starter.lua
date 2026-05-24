local starter = require('mini.starter')

starter.setup({
  evaluate_single = true,
  items = {
    starter.sections.recent_files(5, true),   -- recent files in cwd
    starter.sections.recent_files(5, false),  -- recent files (global)
    starter.sections.builtin_actions(),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.indexing('all', { 'Builtin actions' }),
    starter.gen_hook.padding(3, 2),
    starter.gen_hook.aligning('center', 'center'),
  },
})
