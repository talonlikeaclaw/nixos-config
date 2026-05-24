local gen_loader = require('mini.snippets').gen_loader

require('mini.snippets').setup({
  snippets = {
    gen_loader.from_lang({
      lang_patterns = {
        tsx        = { 'javascript/react-ts.json', 'javascript/typescript.json' },
        jsx        = { 'javascript/react.json', 'javascript/react-es7.json' },
        typescript = { 'javascript/typescript.json' },
        javascript = { 'javascript/javascript.json' },
      },
    }),
  },
  -- Default mappings (insert mode only):
  --   <C-j> expand snippet
  --   <C-l> jump to next tabstop
  --   <C-h> jump to prev tabstop
  --   <C-c> stop snippet session
})
