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
"Plug 'kien/rainbow_parentheses.vim'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Completion
Plug 'benekastah/neomake'
Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'ervandew/supertab'

" Git
Plug 'tpope/vim-fugitive'

" Indent guides
Plug 'nathanaelkane/vim-indent-guides'

" Better whitespace handling
Plug 'ntpeters/vim-better-whitespace'

" Nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'xuyuanp/nerdtree-git-plugin'

" Nerdcommenter
Plug 'scrooloose/nerdcommenter'

" Tex
Plug 'lervag/vimtex', {'for': 'tex'}

" Syntastic
Plug 'scrooloose/syntastic'

" Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

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
  set backupdir=./.backup-vim,~/.backup-vim,.,/tmp
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
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | \
  wincmd p | diffthis
endif

" Colors
set termguicolors
" colorscheme solarized
colorscheme phd
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
  autocmd! BufNewFile,Bufread *.{fab,fil,jif}    setfiletype java
"augroup end

" For youcompleteme + eclim
let g:EclimCompletionMethod = 'omnifunc'
" Turn off eclim's stupid logging 'feature'
let g:EclimLoggingDisabled = 0

" Hitting tab twice in normal mode does ProjectTreeToggle
nnoremap <Tab><Tab> :NERDTreeToggle<cr>

" Add a digraph for ⊤
digraph -t 8868
digraph _U 8852
digraph vc 8407

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

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
let g:markdown_fenced_languages = ['java']

" Binding to more quickly resync syntax highlighting (mostly useful for
" markdown with fenced languages)
nnoremap <leader>l :syntax sync fromstart<cr>
