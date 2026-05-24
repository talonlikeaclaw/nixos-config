vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local map = function(keys, fn, desc)
      vim.keymap.set('n', keys, fn, { buffer = args.buf, desc = desc })
    end
    -- Navigation
    map('gd', vim.lsp.buf.definition,      'Go to definition')
    map('gD', vim.lsp.buf.declaration,     'Go to declaration')
    map('gi', vim.lsp.buf.implementation,  'Go to implementation')
    map('gr', vim.lsp.buf.references,      'Go to references')
    map('gy', vim.lsp.buf.type_definition, 'Go to type definition')
    map('K',  vim.lsp.buf.hover,           'Hover documentation')
    -- <Leader>l group
    map('<leader>lr', vim.lsp.buf.rename,        'Rename symbol')
    map('<leader>la', vim.lsp.buf.code_action,   'Code action')
    map('<leader>lf', vim.lsp.buf.format,        'Format buffer')
    map('<leader>ld', vim.diagnostic.open_float, 'Show diagnostic')
    -- Diagnostic navigation
    map('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
    map(']d', vim.diagnostic.goto_next, 'Next diagnostic')
  end,
})

vim.lsp.enable({
  'lua_ls',
  'rust_analyzer',
  'gopls',
  'pylsp',
  'sqlls',
  'dockerls',
  'yamlls',
  'jsonls',
  'taplo',
  'bashls',
  'vimls',
  'ts_ls',
  'marksman',
  'harper_ls',
  'emmet_ls',
})
