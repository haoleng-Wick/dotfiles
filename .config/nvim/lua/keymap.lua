-- Basic keymap
vim.keymap.set('n', '<C-w>', '<cmd>bdelete<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-n>', '<cmd>bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<C-y>', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', '"+p', { noremap = true, silent = true })

-- LSP keymap
vim.keymap.set('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- Telescope
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

-- Floaterm keymap
vim.keymap.set('n', '<C-t>', '<cmd>FloatermToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-t>', '<C-\\><C-n><cmd>FloatermToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gcc', '<cmd>FloatermNew --autoclose=0 gcc % -o %< && ./%<<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>py', '<cmd>FloatermNew --autoclose=0 python %<CR>', { noremap = true, silent = true })

local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    -- source = "always",  -- Or "if_many"
    prefix = '●', -- Could be '●', '■', '▎', 'x'
  },
  severity_sort = true,
  float = {
    source = "always",  -- Or "if_many"
  },
})
