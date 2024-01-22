vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true


vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.termguicolors = true

vim.cmd([[command! EssayMode source ~/.config/nvim/lua/cyz/essay_mode.lua]])
