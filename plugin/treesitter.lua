vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

local ts_settings = vim.api.nvim_create_augroup('my-ts-settings', { clear = true })

vim.api.nvim_create_autocmd('PackChanged', {
  desc = "Call TSUpdate every time nvim-treesitter is updated",
  group = ts_settings,
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

local languages = {
  'lua', 'rust', 'python', 'go',
  'typescript', 'tsx', 'javascript', 'css',
  'regex', 'markdown', 'c',
}
require('nvim-treesitter').install(languages)

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Set up nvim-treesitter highlighting and indentation',
  group = ts_settings,
  pattern = languages,
  callback = function()
    -- Syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- Indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    -- Folds using treesitter expr, provided by Neovim
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
  end,
})

-- Start every file with folds open
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
