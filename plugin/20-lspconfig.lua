vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

-- Extra lua_ls settings not provided by nvim-lspconfig
vim.lsp.config['lua_ls'] = {
  settings = {
    Lua = {
      -- Specify NeoVim Lua
      runtime = { version = 'LuaJIT', },
      diagnostics = {
        -- Specify vim and plugin globals
        globals = { 'vim', 'MiniIcons', 'MiniFiles' }
      },
    },
  }
}

-- Extra settings for rust_analyzer
vim.lsp.config['rust_analyzer'] = {
  settings = {
    ['rust-analyzer'] = {
      -- Use clippy to check on save
      check = { command = 'clippy' },
    },
  },
}

vim.lsp.enable({
  'lua_ls',
  'rust_analyzer',
})

-- Nicer borders on windows and popups
vim.o.winborder = 'rounded'
vim.o.pumborder = 'rounded'

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
  callback = function(event)
    -- Easier LSP mappings
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Rename the variable under cursor
    map('grn', vim.lsp.buf.rename, 'Rename')

    -- Execute a code action
    map('gra', vim.lsp.buf.code_action, 'Goto Code Action', { 'n', 'x' })

    -- Goto Declaration (not goto definition!)
    map('grD', vim.lsp.buf.declaration, 'Goto Declaration')
  end,
})

-- Diagnostics
vim.diagnostic.config({
  virtual_lines = {
   -- Only show virtual line diagnostics for the current cursor line
   current_line = true,
  },
})
