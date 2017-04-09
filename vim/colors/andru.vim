" Vim color file
" white on black

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
"colorscheme default
let g:colors_name = "andru"

" GUI
hi Normal     guifg=White	guibg=#101040
hi Search     guifg=Black	guibg=Yellow	gui=bold
hi Visual     guifg=#404040			gui=bold
hi Cursor     guifg=Black	guibg=#80ff80	gui=bold
hi Special    guifg=#ffeedd
hi String     guifg=#ffffaa
hi Comment    guifg=#ddffbb
hi StatusLine guifg=#80dd80	guibg=black
hi Type       guifg=#aaffff			gui=NONE
hi Identifier guifg=#ffff99
hi Constant   guifg=White
hi Statement  guifg=#bbbbff
hi PreProc    guifg=Gray

" Console
hi Normal     ctermfg=White	ctermbg=Black
hi Search     ctermfg=Black	ctermbg=Yellow	cterm=NONE
hi Visual					cterm=reverse
hi Cursor     ctermfg=Black	ctermbg=Green	cterm=bold
hi String     ctermfg=Brown
hi Special    ctermfg=Brown
hi Comment    ctermfg=Green
hi StatusLine ctermfg=Green	ctermbg=Black
hi Statement  ctermfg=Cyan			cterm=NONE
hi Type	ctermfg=Yellow					cterm=NONE
