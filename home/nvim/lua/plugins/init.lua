vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  { src = 'https://github.com/nvim-mini/mini.nvim', name = 'mini.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', name = 'nvim-treesitter' },
  { src = 'https://github.com/stevearc/conform.nvim', name = 'conform.nvim' },
  { src = 'https://github.com/kdheepak/lazygit.nvim', name = 'lazygit.nvim' },
  { src = 'https://github.com/christoomey/vim-tmux-navigator', name = 'vim-tmux-navigator' },
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim', name = 'render-markdown.nvim' },
  { src = 'https://github.com/obsidian-nvim/obsidian.nvim', name = 'obsidian.nvim' },
  { src = 'https://github.com/akinsho/toggleterm.nvim', name = 'toggleterm.nvim' },
  { src = 'https://github.com/rafamadriz/friendly-snippets', name = 'friendly-snippets' },
})

vim.cmd.colorscheme('catppuccin-mocha')

require('plugins.icons')
require('plugins.starter')
require('plugins.notify')
require('plugins.format')
require('plugins.snippets')
require('plugins.completion')
require('plugins.clue')
require('plugins.statusline')
require('plugins.diff')
require('plugins.lazygit')
require('plugins.tmux')
require('plugins.files')
require('plugins.pick')
require('plugins.ai')
require('plugins.hipatterns')
require('plugins.indentscope')
require('plugins.jump2d')
require('plugins.move')
require('plugins.pairs')
require('plugins.splitjoin')
require('plugins.surround')
require('plugins.markdown')
require('plugins.obsidian')
require('plugins.toggleterm')
require('plugins.sessions')
require('plugins.treesitter')
