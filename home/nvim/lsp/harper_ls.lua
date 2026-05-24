return {
  cmd = { 'harper-ls', '--stdio' },
  filetypes = {
    'markdown', 'text', 'gitcommit',
    'lua', 'rust', 'go', 'python', 'typescript', 'javascript',
    'typescriptreact', 'javascriptreact', 'shellscript', 'toml',
  },
  root_markers = { '.git' },
  settings = {
    ['harper-ls'] = {
      diagnosticSeverity = 'hint',
    },
  },
}
