require('conform').setup({
  default_format_opts = {
    lsp_format = 'fallback', -- fall back to LSP if no formatter configured
    timeout_ms = 500,
  },

  formatters_by_ft = {
    lua        = { 'stylua' },
    rust       = { 'rustfmt' },
    go         = { 'goimports', 'gofmt' },
    python     = { 'ruff_format' },
    javascript      = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescript      = { 'prettier' },
    typescriptreact = { 'prettier' },
    html       = { 'prettier' },
    css        = { 'prettier' },
    json       = { 'prettier' },
    yaml       = { 'prettier' },
    markdown   = { 'prettier' },
    bash       = { 'shfmt' },
    sh         = { 'shfmt' },
    toml       = { 'taplo' },
    sql        = { 'sql_formatter' },
    -- trim whitespace on anything else
    ['_']      = { 'trim_whitespace' },
  },

  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = 'fallback' }
  end,
})

-- Toggle format-on-save (global or buffer-local)
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { bang = true, desc = 'Disable format on save (!= buffer-local)' })

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { desc = 'Enable format on save' })
