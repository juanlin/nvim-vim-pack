local misc = require('mini.misc')
local later = function(f) misc.safely('later', f) end

later(function()
  vim.pack.add({ 'https://github.com/juanlin/which-key.nvim' })

  require('which-key').setup({
    delay = 250,
    spec = {
      -- Name group keys
      { '<leader>f', group = 'Pick [F]', icon = { icon = '', color = 'cyan' } },
      { 'gs', group = 'Surround', mode = { 'n', 'x' } },
      { 'gr', group = 'LSP', mode = { 'n', 'x' } },

      -- Hide mappings for cleaner menus
      { '<leader>P', hidden = true, mode = { 'n', 'x' } },  -- OS pre-paste
      { '<leader>E', hidden = true },   -- explore cwd
      { '<C-w>d', hidden = true },      -- diagnostics
      { '<C-w><C-d>', hidden = true },  -- diagnostics

      -- Set as proxy to <C-w> (do not map elsewhere to avoid issues)
      { '<leader>w', proxy = '<C-w>', group = 'Window commands' },

      -- Assign custom icons to keymaps
      { '<leader>y', icon = '', mode = { 'n', 'x' } },
      { '<leader>p', icon = '', mode = { 'n', 'x' } },
      { '<leader>e', icon = { icon = ' ', color = 'cyan' } },
      { icon = { icon = '', color = 'cyan' },
        { '<leader>ff' }, { '<leader>fb' }, { '<leader>fo' }
      }
    },
    preset = 'helix', -- classic, modern, helix
  })

  -- Pressing <Space> enters Sticky mode (Hydra mode)
  vim.keymap.set('n', '<C-w><Space>', function()
    require('which-key').show({ keys = '<C-w>', loop = true, })
  end, { desc = 'Sticky Mode' })
end)
