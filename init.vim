call plug#begin() 

"Git client
Plug 'tpope/vim-fugitive'
"File tree
Plug 'scrooloose/nerdtree'
"File icons
Plug 'ryanoasis/vim-devicons'
"Color for the icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Status bar
Plug 'vim-airline/vim-airline'
"Color scheme
Plug 'joshdick/onedark.vim'
"Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile && yarn build'}
" Syntax checking
Plug 'scrooloose/syntastic'

"--CoC Language Plugins
"Java
Plug 'neoclide/coc-java'
"Snippets
Plug 'neoclide/coc-snippets'
" Typescript
Plug 'neoclide/coc-tsserver'
" css
Plug 'neoclide/coc-css'
" Shell script
Plug 'josa42/coc-sh'
" Rust
Plug 'neoclide/coc-rls'
" Prettier
Plug 'neoclide/coc-rls'
" Json
Plug 'neoclide/coc-json'

call plug#end()

"Normal mode mappings
nnoremap <C-n> :NERDTreeToggle<CR>
" Go to terminal by pressing ctrl-j
nnoremap <C-j> <Esc><C-w>ja

" Go to file tree by pressing ctrl-h
nnoremap <C-h> <C-w><C-h>

" Return from the file tree by pressing ctrl-l
nnoremap <C-l> <C-w><C-l>

" Write and close the file
nnoremap <C-q> :w<Enter>:qa<Enter>

" move tabs left and right
nnoremap <C-Up> :tabmove +1<cr>
nnoremap <C-Down> :tabmove - 1<cr>

" Open tabs to the left or right
nnoremap <C-Right> :tabn<CR>
nnoremap <C-Left> :tabp<CR>

"Terminal mode mappings
tnoremap <Esc> <C-\><C-n><C-w>k

" Visual mod mappings

" Replace text withing a selected area
vnoremap <S-r> <esc> :call ReplaceText() <CR>

function ReplaceText()
	
endfunction

"--Autocompletes for parenthesis, brackets, and quotations

" Parenthesis
noremap ( ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

" Go to terminal by pressing ctrl-a
inoremap <C-j> <Esc><C-w>ja

" Custom commands

" Create and setup a new tab
command! -nargs=1 Newtab call s:tabnew(<f-args>)

function! s:tabnew(file) 
	tabnew file
	split | term
	res -15
	NERDTreeToggle
	wincmd l
endfunction

"Line numbers
set number

" change tab length
set tabstop=4
set softtabstop=4
set shiftwidth=4

" disable line wrapping
set nowrap

"Open nerd tree automatically
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd w

"Create a terminal below the main window and resize it
set splitbelow
autocmd TermOpen * setlocal nonumber norelativenumber
"spit | term
"res -15

"Makes the window seperators thin
highlight VertSplit term=None cterm=None gui=None guifg=None guibg=None ctermfg=None ctermbg=None

"Makes blank lines actually blank
highlight EndOfBuffer ctermfg=black ctermbg=black

"Global status bar
set laststatus=3

"Makes folder icons look better
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1

"Enable hidden files on Nerdtree
let NERDTreeShowHidden=1

"enable color scheme
syntax on
colorscheme onedark

"Enable full colorpallete
set tgc

"CoC config
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300


" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Navigate autocomplete menu with tab and shift-tab
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Trigger autocomplete with enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:syntastic_mode_map = { 'passive_filetypes': ['asm'] }

"--End Startup Logic--"
