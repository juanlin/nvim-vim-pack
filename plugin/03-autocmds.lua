-- Return cursor ignore list (exact match)
local ignore_ft = {
  gitcommit = true,
  gitrebase = true,
  xxd = true,
  tutor = true,
}

-- Localize API calls (LuaJIT optimization)
local get_mark = vim.api.nvim_buf_get_mark
local line_count = vim.api.nvim_buf_line_count
local set_cursor = vim.api.nvim_win_set_cursor

local general_settings = vim.api.nvim_create_augroup('my-general-settings', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  desc = "Don't auto-insert comments on new lines",
  group = general_settings,
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove{'c', 'r', 'o'}
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Return cursor to last known position',
  group = general_settings,
  pattern = '*',
  callback = function()
    local ft = vim.bo.filetype
    -- print(vim.inspect(ft))

    if ignore_ft[ft] or vim.wo.diff then
      return
    end

    local mark = get_mark(0, '"')
    local lcount = line_count(0)

    -- mark[1] is the line number of the mark
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = general_settings,
  callback = function()
    vim.hl.on_yank({
      -- timeout = 300,
    })
  end,
})
