setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal smarttab
setlocal expandtab
setlocal autoindent
setlocal foldmethod=manual
" Turn on pymode?
let g:pymode = 1
let g:pymode_python = 'python3'
let g:pymode_paths = ['', '/usr/lib/python36.zip', '/usr/lib/python3.6', '/usr/lib/python3.6/lib-dynload', '/usr/lib/python3.6/site-packages', '~/dotfiles/vim/plugged/python-mode']
"let g:pymode_options = 1
"let g:pymode_folding = 0
"let g:pymode_lint = 1
"let g:pymode_lint_on_write = 1
"let g:pymode_lint_unmodified = 1
""let g:pymode_lint_on_fly = 1
""let g:pymode_lint_checkers = ['pylint', 'pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_checkers = ['pylama', 'pyflakes', 'pep8', 'mccabe']
"nnoremap <silent> <buffer> <leader>f :PymodeLintAuto<cr>
let g:flake8_show_in_gutter=1
