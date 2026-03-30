vim.pack.add({
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/karb94/neoscroll.nvim',
})

require('neoscroll').setup({
  -- easing = 'sine',
  duration_multiplier = 0.30,
})
