vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('mini.surround').setup({
  -- Add g- prefix to avoid clobbering
  mappings = {
    add = 'gsa',
    delete = 'gsd',
    find = 'gsf',
    find_left = 'gsF',
    highlight = 'gsh',
    replace = 'gsr',
    update_n_lines = 'gsn',
  },
})

local misc = require('mini.misc')
local later = function(f) misc.safely('later', f) end
later(function()
  require('mini.cmdline').setup()
end)

require('mini.indentscope').setup({
  symbol = '',
  options = {
    try_as_border = true,
  }
})

require('mini.notify').setup()

-- Provide extra sources for picker (i.e.: oldfiles)
require('mini.extra').setup()

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

require('mini.completion').setup()
