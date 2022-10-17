vim.o.encoding = "UTF-8"
vim.o.autowrite = true -- 自动保存
vim.o.autoread = true -- 文件被改动时自动载入

vim.o.cursorline = true

vim.o.autoindent = true -- 新增加的行和前一行使用相同的缩进形式

-- vim.o.completeopt = "menuone,noinsert,noselect"
-- vim.o.shortmess = vim.o.shortmess .. "c" -- Avoid showing message extra message when using completion

-- vim.o.mouse = "a" -- enable mouse

vim.cmd("filetype on")
vim.cmd("filetype indent on")
vim.cmd("filetype plugin on")
vim.cmd("filetype plugin indent on")

vim.cmd("syntax enable") -- 开启语法高亮功能
vim.cmd("syntax on") -- 自动语法高亮

-- vim.cmd("set number")
