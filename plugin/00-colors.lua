vim.pack.add({
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' }
})

require('catppuccin').setup({
  background = { dark = 'macchiato' },
  -- transparent_background = true,
})

vim.cmd.colorscheme 'catppuccin-nvim'
