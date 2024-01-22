
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])
vim.opt.updatetime = 50

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Reformat
-- vim.keymap.set("n", "<leader>R", )

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

