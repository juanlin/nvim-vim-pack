vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('mini.notify').setup()

local misc = require('mini.misc')
local later = function(f) misc.safely('later', f) end
local on_event = function(ev, f) misc.safely('event:' .. ev, f) end

later(function()
  require('mini.cmdline').setup()
  require('mini.indentscope').setup({
    symbol = '',
    options = {
      try_as_border = true,
    }
  })
  require('mini.surround').setup({
    mappings = {
      -- Add g- prefix to avoid clobbering
      add = 'gsa',
      delete = 'gsd',
      find = 'gsf',
      find_left = 'gsF',
      highlight = 'gsh',
      replace = 'gsr',
      update_n_lines = 'gsn',
    },
  })
  require('mini.extra').setup() -- extra resources for picker (i.e.: oldfiles)
  require('mini.pick').setup({
    mappings = {
      move_down = '<C-j>',
      move_up = '<C-k>',
    }
  })
  vim.keymap.set('n', '<leader>ff', '<Cmd>Pick files<CR>', { desc = 'Files' })
  vim.keymap.set('n', '<leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Grep live' })
  vim.keymap.set('n', '<leader>fb', '<Cmd>Pick buffers<CR>', { desc = 'Buffers' })
  vim.keymap.set('n', '<leader>fo', '<Cmd>Pick oldfiles<CR>', { desc = 'Old files' })
  vim.keymap.set('n', '<leader>fh', '<Cmd>Pick history<CR>', { desc = 'History' })

  vim.pack.add({
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/karb94/neoscroll.nvim',
    'https://github.com/brenoprata10/nvim-highlight-colors',
  })
  require('neoscroll').setup({
    -- easing = 'sine',
    duration_multiplier = 0.30,
  })
  require('nvim-highlight-colors').setup({
    render = 'background',  -- background, foreground, virtual
    virtual_symbol_position = 'eol' -- inline, eol, eow
  })
  require('nvim-highlight-colors').turnOff()
  vim.keymap.set('n', '<leader>c', '<Cmd>HighlightColors Toggle<CR>', { desc = 'Toggle CSS colors' })
end)

on_event('InsertEnter', function()
  require('mini.completion').setup()
end)
