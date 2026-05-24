require('mini.icons').setup()

-- Mock nvim-web-devicons so plugins expecting it get icons from mini.icons
MiniIcons.mock_nvim_web_devicons()

-- Improve LSP kind icons (completion menu, pickers)
MiniIcons.tweak_lsp_kind()
