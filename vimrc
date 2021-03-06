" Tom Magrino's vimrc

" Install vim-plug if we don't have it already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Manage plugins with vim-plug
call plug#begin('~/.vim/plugged')

" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/phd'
Plug 'junegunn/rainbow_parentheses.vim'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Completion
Plug 'ervandew/supertab'
if has('nvim')
	" This was moved to the updated
	"Plug 'roxma/nvim-completion-manager'
	Plug 'ncm2/ncm2'
	" Turning this off for now because it forces an update each time it
	" refreshes...
	"Plug 'sassanh/nvim-cm-eclim'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'deoplete-plugins/deoplete-clang'
else
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
	Plug 'deoplete-plugins/deoplete-clang'
endif

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Indent guides
Plug 'nathanaelkane/vim-indent-guides'

" Table mode
" Maybe later, I'm not digging it right now.
"Plug 'dhruvasagar/vim-table-mode'

" Better whitespace handling
Plug 'ntpeters/vim-better-whitespace'

" Nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'albfan/nerdtree-git-plugin'

" Nerdcommenter
Plug 'scrooloose/nerdcommenter'

" Syntastic
Plug 'scrooloose/syntastic', {'for': 'tex'}

" Tex
Plug 'lervag/vimtex', {'for': 'tex'}

" Syntax Linting
"Plug 'w0rp/ale'

" Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

" Fancy surround movements
Plug 'tpope/vim-surround'

" Fancy fuzzy file searching
Plug 'ctrlpvim/ctrlp.vim'

" Haskell
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
Plug 'parsonsmatt/intero-neovim', {'for': 'haskell'}

" Python
Plug 'klen/python-mode', {'branch': 'develop'}
Plug 'vim-scripts/indentpython.vim', {'for': 'python'}

" Mathematica?
Plug 'rsmenon/vim-mathematica', {'for': 'mma'}

" Java
Plug 'npacker/vim-java-syntax-after', {'for': 'java'}

" C/C++
Plug 'ludovicchabant/vim-gutentags', {'for': 'cpp'}
Plug 'majutsushi/tagbar', {'for': 'cpp'}

" End vim-plug plugins
call plug#end()

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
  set backupdir=./.backup-vim//,~/.backup-vim//,.//,/tmp//
endif
set history=50			" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch			" do incremental searching
" keep tag file in homedir or current directory.
set tags=~/.tags,./.tags,./tags;/
set number			" number lines

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 72 characters.
  autocmd FileType text setlocal textwidth=72

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
			  \ | wincmd p | diffthis
endif

" Colors
set termguicolors
"set background=dark
"colorscheme solarized
colorscheme phd
"colorscheme andru
"colorscheme molokai_dark
set colorcolumn=+1
" highlight ColorColumn guibg=#324454
highlight ColorColumn guibg=#030a54

" Set <leader> to - globally and _ locally
let mapleader="-"
let maplocalleader="_"

" Edit and reload source
nnoremap <leader>ev :sp $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Remove search highlighting
nnoremap <leader>cl :nohl<cr>

" Enable indent guides
let g:indent_guides_enable_on_vim_startup = 1

" Ale
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1

" No arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Fix common typos
" iabbrev dont don't
" iabbrev taht that

"augroup filetypedetect
  " Treat fab and fil files like java.
  autocmd BufNewFile,Bufread *.{fab,fil,jif}    setfiletype java
  autocmd BufNewFile,Bufread *.ppg		 setfiletype ppg
  autocmd BufNewFile,Bufread *.{plot,gplot,gnuplot,gplt} setfiletype gnuplot
"augroup end

" Hitting tab twice in normal mode does ProjectTreeToggle but also expands to
" the current file, if possible.
function! FancyOpenNerdTree()
	let file = expand("%")
	execute ":NERDTreeToggle"
	if filereadable(file)
		execute ":NERDTreeFind " . file
	endif
	execute ":NERDTreeMirror"
endfunction
nnoremap <Tab><Tab> :call FancyOpenNerdTree()<cr>
" Close if NERDTree's the only one left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Add a digraph for ⊤
digraph -t 8868
digraph _U 8852
digraph vc 8407

" NERDCommenter
" Left align comments for commented out code.
let g:NERDDefaultAlign = 'left'
" Include blank lines in commenting regions of code.
let g:NERDCommentEmptyLines = 1

" UltiSnips
"let g:UltiSnipsExpandTrigger = '<c-j>'
"let g:UltiSnipsJumpForwardTrigger = '<c-j>'
"let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" Open a terminal
nnoremap <leader>t :sp term://$SHELL<cr>i
" Esc to exit insert mode in a terminal
tnoremap <esc> <C-\><C-n>

" Handle markdown highlighting of java code
let g:markdown_fenced_languages = ['java', 'sh']

" Binding to more quickly resync syntax highlighting (mostly useful for
" markdown with fenced languages)
nnoremap <leader>l :syntax sync fromstart<cr>
" Close if quickfix list is the only one left
autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
	\   q :cclose<cr>:lclose<cr>
autocmd BufEnter * if (winnr('$') == 1 && &buftype ==# 'quickfix' ) |
	\   bd|
	\   q | endif

" Turn on rainbow parens.
au BufEnter * RainbowParentheses
" Add other kinds of parens.
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" Using pymode, with python3 because we don't live in the early 20[10]0s still
let g:pymode = 1
let g:pymode_python = 'python3'

" Turn on indent guides
au BufEnter * IndentGuidesEnable

" Turn on deoplete
"let g:deoplete#enable_at_startup = 1

" Show docstring in preview for jedi
"let g:deoplete#sources#jedi#show_docstring = 1

" Turn off eclim's stupid logging 'feature'
let g:EclimLoggingDisabled = 0

" Show preview window and close it when out of insert mode for
" nvim-completion-manager
" From: https://github.com/roxma/nvim-completion-manager/issues/132
" Add preview to see docstrings in the complete window.
let g:cm_completeopt = 'menu,menuone,noinsert,noselect,preview'

" Close the prevew window automatically on InsertLeave
" https://github.com/davidhalter/jedi-vim/blob/eba90e615d73020365d43495fca349e5a2d4f995/ftplugin/python/jedi.vim#L44
augroup ncm_preview
	autocmd! InsertLeave <buffer> if pumvisible() == 0|pclose|endif
augroup END

" Turn off SuperTab's "feature" of showing options backwards.
let g:SuperTabDefaultCompletionType = "<c-n>"

" Turn off eclim validation for python
let g:EclimPythonValidate = 0

" Sort eclim validation results by severity, rather than occurrence.
let g:EclimValidateSortResults = 'severity'

" Make enter not just hide the auto completion list but also line break
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Don't use javac with ALE, that's dumb.
let g:ale_linters = {
\ 'java': [],
\}

" Use deoplete as a completion source for nvim-completion-manager
" From https://github.com/roxma/nvim-completion-manager/issues/50
" force init deoplete then hack deoplete's mapping
call deoplete#enable()

" register as ncm source
au User CmSetup call cm#register_source({'name' : 'deoplete',
        \ 'priority': 7,  
        \ 'abbreviation': '', 
        \ })

" hack deoplete's mapping
inoremap <silent> <Plug>_ <C-r>=g:Deoplete_ncm()<CR>

func! g:Deoplete_ncm()
  " forward to ncm
  call cm#complete('deoplete', cm#context(), g:deoplete#_context.complete_position + 1, g:deoplete#_context.candidates)
  return ''
endfunc

" Assume latex unless told otherwise.
let g:tex_flavor = "latex"

" Ignore latex cruft, NERDTree
let NERDTreeIgnore=['\.aux$', '\.auxlock$', '\.bbl$', '\.blg$', '\.lof$', '\.log$', '\.lot$', '\.toc$']

" underline misspelled words
hi SpellBad cterm=underline
hi SpellBad gui=undercurl

" When sytnastic is on, always populate the location list.
let g:sytnastic_always_populate_loc_list = 1
let g:sytnastic_check_on_open = 1
let g:sytnastic_aggregate_errors = 1
