vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

-- Mini Icons non-lazy for dependency
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

-- Mini Notify non-lazy for error messages maybe?
require('mini.notify').setup()

-- Mini lazy "later" and "on_event" loading
local misc = require('mini.misc')
local later = function(f) misc.safely('later', f) end
local on_event = function(ev, f) misc.safely('event:' .. ev, f) end

later(function()
  -- Mini Commandline Completion
  require('mini.cmdline').setup()

  -- Mini Indentscope
  require('mini.indentscope').setup({
    symbol = '',
    options = {
      try_as_border = true,
    }
  })

  -- Mini Surround
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

  -- Mini Pick
  local MiniPick = require('mini.pick')

  MiniPick.setup({
    mappings = {
      move_down = '<C-j>',
      move_up = '<C-k>',
    }
  })

  -- Pick Recent Files (clean: no current files, no git msg, no URIs)
  local pick_recentfiles_clean = function()
    -- Get a list of normalized paths currently visible in windows
    local visible_files = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= '' then
        visible_files[vim.fs.normalize(name)] = true
      end
    end

    local all_recentfiles = vim.v.oldfiles

    local filtered_recentfiles = vim.tbl_filter(function(path)
      -- Check if normalized path is in our "visible" lookup table
      if visible_files[vim.fs.normalize(path)] then return false end

      -- Check if it's a commit message
      if path:find('.git/COMMIT_EDITMSG', 1, true) then return false end

      -- Check for special plugin/internal URIs
      if path:find('nvim-pack://', 1, true) or
        path:find('fugitive://', 1, true) or
        path:find('health://', 1, true) then
        return false
      end

      return true
    end, all_recentfiles)

    MiniPick.start({
      source = {
        items = filtered_recentfiles,
        name = 'Recent Files (Clean)',
        choose = MiniPick.default_choose,
      },
    })
  end

  -- Pick Command History
  local pick_command_history = function()
    local history_list = {}
    local seen = {}   -- table to track duplicates
    local history_count = vim.fn.histnr(':')

    -- Build the list from newest to oldest
    for i = history_count, 1, -1 do
      local cmd = vim.fn.histget(':', i)
      -- No empty, duplicates, or short commands
      if cmd ~= '' and not seen[cmd] and #cmd >2 then
        table.insert(history_list, cmd)
        seen[cmd] = true  -- mark as seen
      end
    end

    MiniPick.start({
      source = {
        items = history_list,
        name = 'Command History',
        choose = function(item)
          vim.api.nvim_feedkeys(':' .. item, 'n', true)
        end,
      },
    })
  end

  vim.keymap.set('n', '<leader>ff', '<Cmd>Pick files<CR>', { desc = 'Files' })
  vim.keymap.set('n', '<leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Grep live' })
  vim.keymap.set('n', '<leader>fb', '<Cmd>Pick buffers<CR>', { desc = 'Buffers' })
  vim.keymap.set('n', '<leader>fo', pick_recentfiles_clean, { desc = 'Recent Files' })
  vim.keymap.set('n', '<leader>fh', pick_command_history, { desc = 'Command History' })

  -- OTHER non-mini plugins
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

-- Mini Completion (trigger on InsertEnter)
on_event('InsertEnter', function()
  require('mini.completion').setup()
end)
