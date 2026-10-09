-------------------------------------------------

--- KEYS MAPPINGS 
-------------------------------------------------

-- vim.g.mapleader = " " -- Gán Space làm Leader key
vim.g.mapleader = ";"
vim.api.nvim_set_keymap('i','jk','<ESC>', {noremap = true })
vim.keymap.set('n', '<leader>Q', ':wq!<CR>', { desc = 'Save and close' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Close close' })
vim.keymap.set('n', '<leader>W', ':wa<CR>', { desc = 'Save all' })
--Tab control
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'move to the left tab',noremap = true, silent=false })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'move to the below tab',noremap = true, silent=false })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'move to the above tab ',noremap = true, silent=false })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'move to the right tab',noremap = true, silent=false })
--
vim.keymap.set('v','>','>gv',{noremap=true, silent=false})
vim.keymap.set('v','<','<gv',{noremap=true, silent=false})
-- Mở terminal bên phải (vsplit)
vim.keymap.set('n', 'tl', ':vsplit | terminal<CR>', { noremap = true, silent = true })

-- Mở terminal bên dưới (split)
vim.keymap.set('n', 'tj', ':split | terminal<CR>', { noremap = true, silent = true })
--- TELESCOPE KEY MAPPINGS
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>st', function () 
    builtin.find_files {cwd =vim.fn.stdpath("config")}
end)

-- Xóa trong chế độ Normal
vim.keymap.set('n', '<leader>x', '"_x', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d', '"_dd', { noremap = true, silent = true })

-- Xóa trong chế độ Visual
vim.keymap.set('v', 'd', '"_d', { noremap = true, silent = true })



-- NVIM TREE KEY MAPPINGS
local api = require "nvim-tree.api"
vim.keymap.set('n','<leader>;',api.tree.toggle, {desc="Toggle tree "})
