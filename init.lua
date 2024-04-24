local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	'scrooloose/nerdtree', -- File tree
	'tpope/vim-fugitive', -- Execute git commands from within nvim
	'airblade/vim-gitgutter', -- display git diff signs
	'vim-airline/vim-airline', -- Display bar at the bottom of the window
	'chrisbra/csv.vim', -- Support for csv files

})

-- plugin configs
require('pluginConfig')

-- variable configuration
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- create a terminal
vim.cmd([[
	autocmd TermOpen * setlocal nonumber norelativenumber
	split
	term
	resize -10
]])

-- keybinds
map = vim.keymap.set
map({'i', 'n'}, '<c-n>', '<cmd>:NERDTreeToggle<cr>', {noremap=true})
map({'i', 'n'}, '<c-h>', '<cmd>:nohl<cr>', {noremap=true})
map({'n'}, '<c-right>', '<cmd>:bnext<cr>', {noremap=true})
