return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        -- Make lua_ls aware of Neovim's runtime files (vim.* globals, etc.)
        library = vim.api.nvim_get_runtime_file('', true),
      },
    },
  },
}
