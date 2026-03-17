local function initials(mode)
  local i = mode:find('-', 1, true)
  if i and i < #mode then
    return mode:sub(1, 1) .. '-' .. mode:sub(i+1, i+1)
  end
  return mode:sub(1, 1)
end

local function width_gt(limit)
  return vim.api.nvim_win_get_width(0) > limit
end

vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    refresh = {
      statusline = 75,  -- default 100ms
    }
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(str)
          if width_gt(70) then
            return str
          end
          return initials(str)
        end,
      },
    },
    lualine_b = {
      { 'branch', icon = '' },
      { 'diff' },
      { 'diagnostics' },
    },
    lualine_x = {
      { 'encoding', cond = function() return width_gt(75) end },
      { 'fileformat', cond = function() return width_gt(70) end },
      { 'filetype', cond = function() return width_gt(60) end },
    },
  },
})

vim.opt.showmode = false  -- hide mode notification
