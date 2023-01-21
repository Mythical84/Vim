call plug#begin() 

" Git client
Plug 'tpope/vim-fugitive'
" File icons
Plug 'ryanoasis/vim-devicons'
" Color for the icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" File tree
Plug 'scrooloose/nerdtree'
" Status bar
Plug 'vim-airline/vim-airline'
" Color scheme
Plug 'joshdick/onedark.vim'
" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile && yarn build'}
" Syntax checking
Plug 'scrooloose/syntastic'
" Svelte syntax highlighting
Plug 'burner/vim-svelte'
" Javascript syntax highlighting
Plug 'pangloss/vim-javascript'
" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'
" Parenthesis autocomplete
Plug 'jiangmiao/auto-pairs'
" Markdown syntax support
Plug 'plasticboy/vim-markdown'
" Markdown preview
Plug 'suan/vim-instant-markdown'
" Prettier
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
" Set filetype based on location in file (Useful for svelte)


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
Plug 'neoclide/coc-prettier'
" Json
Plug 'neoclide/coc-json'
" Svelte
Plug 'codechips/coc-svelte', {'do': 'npm install'}
" Python
Plug 'fannheyward/coc-pyright'

call plug#end()

"Normal mode mappings
nnoremap <C-n> :NERDTreeToggle<Enter><C-l>

" Write and close the file
nnoremap <C-q> :w<Enter>:qa<Enter>

" Move to the next or previous buffer
nnoremap <C-Right> :bnext<cr>
nnoremap <C-Left> :bprevious<cr>

"Terminal mode mappings
tnoremap <Esc> <C-\><C-n>

tnoremap <C-Left> <Esc> :bprevious
tnoremap <C-Left> <Esc> :bnext

" Visual mode mappings

" Replace text withing a selected area
vnoremap <S-r> <esc> :call ReplaceText() <CR>

function ReplaceText()
	
endfunction

" Custom commands

:command! Bq execute QuitBuffer()

function QuitBuffer()
	:bd!
	:bprevious
	:NERDTreeToggle
	:wincmd l
endfunction

" Go to terminal by pressing ctrl-a
inoremap <C-j> <Esc><C-w>ja

" Non plugin specific configs

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
autocmd TermOpen * setlocal nonumber norelativenumber
enew
term
bprevious

"Makes the window seperators thin
highlight VertSplit term=None cterm=None gui=None guifg=None guibg=None ctermfg=None ctermbg=None

"Makes blank lines actually blank
highlight EndOfBuffer ctermfg=black ctermbg=black

"Global status bar
set laststatus=3

"enable color scheme
syntax on
colorscheme onedark

"Enable full colorpallete
set tgc

" Enable code folding
:set foldenable

"--Begin Plugin Config-- "

" --Begin NERDTree Config-- "

"Makes folder icons look better
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1

"Enable hidden files on Nerdtree
let NERDTreeShowHidden=1

" --End NERDTree Config-- "

" --Begin CoC config-- "
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

" --End CoC config-- "

" --Begin Syntastic Config-- "

" Disable syntastic on assembly files
let g:syntastic_mode_map = { 'passive_filetypes': ['asm'] }

" --End Syntasic config-- "

" --Begin airline config-- "

let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#fnamemod = ":t"

let g:airline#extensions#syntastic#stl_format_error = 1

let g:airline#extensions#syntastic#stl_format_warn = 1

" --End airline config-- "

" --Start prettier config-- "

let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat_require_pragma = 0
au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync

" --End prettier config-- "

" --Start context filetype config -- "

if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif

let g:context_filetype#filetypes.svelte =
\ [
\   {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
\   {
\     'filetype': 'typescript',
\     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
\     'end': '',
\   },
\   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
\ ]

let g:ft = ''

" --End context filetype config -- " 

" --End Startup Logic-- "
