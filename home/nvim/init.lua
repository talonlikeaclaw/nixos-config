-- Neovim v0.12.0 Configuration
-- Resources:
-- 	- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
-- 	- https://neovim.io/doc/user/lsp/

vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('builtins')
require('options')
require('keymaps')
require('plugins')
require('lsp')
