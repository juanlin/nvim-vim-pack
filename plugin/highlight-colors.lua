vim.pack.add({ 'https://github.com/brenoprata10/nvim-highlight-colors' })

require('nvim-highlight-colors').setup({
  render = 'background',  -- background, foreground, virtual
  virtual_symbol_position = 'eol' -- inline, eol, eow
})

require('nvim-highlight-colors').turnOff()

vim.keymap.set('n', '<leader>c',
  '<Cmd>HighlightColors Toggle<CR>',
  { desc = 'Toggle CSS colors' })
