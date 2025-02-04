vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.cmd([[set breakindent]])
    -- ident by an additional 2 characters on wrapped lines, when line >= 40 characters, put 'showbreak' at start of line
vim.cmd([[set breakindentopt=shift:2,min:40,sbr]])


vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.termguicolors = true

vim.cmd([[let g:tex_flavor = "latex"]])
vim.cmd([[command! EssayMode source ~/.config/nvim/lua/cyz/essay_mode.lua]])
vim.cmd([[command W w]])
vim.cmd([[command Q q]])
vim.cmd([[set spell]])


