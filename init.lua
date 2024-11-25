local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
require('lazy_install.lua')
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	'scrooloose/nerdtree', -- File tree
	'tpope/vim-fugitive', -- Execute git commands from within nvim
	'airblade/vim-gitgutter', -- display git diff signs
	'vim-airline/vim-airline', -- Display bar at the bottom of the window
	'chrisbra/csv.vim', -- Support for csv files
	'joshdick/onedark.vim', -- Color scheme
	'tpope/vim-surround', -- Automatically change or add quotes or parenthesis
	'scrooloose/syntastic', -- Syntax Checking
	{'neoclide/coc.nvim', branch='release', build='npm ci'}, -- Auto complete code
	'raimondi/delimitmate', -- Auto complete quotes and parenthesis
	'myusuf3/numbers.vim', -- Change line numbers based on mode 
	'evanleck/vim-svelte', -- Highlight support for svelte
	'qnighy/lalrpop.vim', -- Syntax highlighting for lalrpop
})

-- plugin configs
require('pluginConfig')

-- variables
local terminal = true

-- variable configuration
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- set colorscheme
vim.cmd.colorscheme('onedark')
vim.cmd('highlight LineNr ctermfg=grey')

-- create a terminal buffer
vim.cmd([[
	autocmd TermOpen * setlocal nonumber norelativenumber
	enew
	term
	bp
]])

-- custom quit command
vim.api.nvim_create_user_command("Q", function(opts)
	local bufnr = vim.fn.bufnr()
	vim.cmd('bp')
	if vim.bo.buftype == 'terminal' then
		vim.cmd('bp')
		if bufnr == vim.fn.bufnr() then
			vim.cmd('q')
			if terminal then vim.cmd('q') end
		end
	end
	vim.cmd(bufnr.."bw")
end, { nargs = 0 })

-- close nvim completely
vim.api.nvim_create_user_command("Qq", function(opts)
	while true do
		if vim.bo.buftype == '' then
			vim.cmd('w')
		end
		vim.cmd('q')
	end
end, { nargs = 0})

-- keybinds
map = vim.keymap.set
map({'i', 'n'}, '<c-n>', '<cmd>:NERDTreeToggle<cr>', {noremap=true})
map({'i', 'n'}, '<c-h>', '<cmd>:nohl<cr>', {noremap=true})
map({'n'}, '<c-right>', '<cmd>:lua changeBuf(\'bn\')<cr>', {noremap=true})
map({'n'}, '<c-left>', '<cmd>:lua changeBuf(\'bp\')<cr>', {noremap=true})
map({'n', 't'} ,'<c-t>', '<cmd>:lua swapTerm()<cr>', {noremap=true})

-- change selected buffer and skip terminal
function changeBuf(cmd)
	vim.cmd(cmd)
	if vim.bo.buftype == 'terminal' then
		vim.cmd(cmd)
		print(vim.bo.buftype)
	end
end

-- enable or disable the terminal
function swapTerm()
	vim.cmd('wincmd j')
	if vim.bo.buftype == 'terminal' then
		vim.cmd('q')
		terminal = false
	else
		term()
		vim.cmd('startinsert')
		terminal = true
	end
end

-- open the terminal
function term()
	vim.cmd([[
		split
		resize -10
		buffer 2
	]])
end
