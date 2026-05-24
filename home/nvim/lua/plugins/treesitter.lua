local ts = require('nvim-treesitter')

-- Install parsers for all languages in use (skips already-installed ones)
ts.install({
  -- Neovim / meta
  'vim', 'vimdoc', 'query', 'lua',
  -- Systems
  'rust', 'go', 'c',
  -- Scripting
  'python', 'bash',
  -- Web
  'javascript', 'typescript', 'tsx', 'html', 'css',
  -- Data / config
  'json', 'yaml', 'toml', 'sql',
  -- Docs / infra
  'markdown', 'markdown_inline', 'dockerfile', 'regex', 'comment',
})

-- Enable treesitter features for any filetype that has a parser installed
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match) or args.match
    if pcall(vim.treesitter.language.inspect, lang) then
      vim.treesitter.start()                                           -- highlighting
      vim.wo.foldmethod = 'expr'                                       -- folding
      vim.wo.foldexpr   = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldlevel  = 99                                           -- start with all folds open
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
    end
  end,
})
