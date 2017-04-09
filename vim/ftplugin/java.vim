setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab

" Hack for toggling on and off folding of comments
let b:foldJavaComments = 1
function! ToggleJavaCommentsFold()
	syntax clear javaDocComment
	if b:foldJavaComments
		" If was folded, unfold
		let b:foldJavaComments = 0
		syn region javaDocComment start="/\*\*" end="\*/" keepend contains=javaCommentTitle,@javaHtml,javaDocTags,javaDocSeeTag,javaTodo,@Spell
		setlocal foldmethod=syntax
	else
		let b:foldJavaComments = 1
		syn region javaDocComment start="/\*\*" end="\*/" keepend contains=javaCommentTitle,@javaHtml,javaDocTags,javaDocSeeTag,javaTodo,@Spell fold
		setlocal foldmethod=syntax
	endif
endfunction
nnoremap <localleader>cc :call ToggleJavaCommentsFold()<CR>

" Suggested Eclim Bindings
" Format entire file
nnoremap <silent> <buffer> <leader>f :JavaImportOrganize<cr>:%JavaFormat<cr>
" Import what's under the cursor
nnoremap <silent> <buffer> <leader>i :JavaImportOrganize<cr>
" Search JavaDocs
nnoremap <silent> <buffer> <leader>jd :JavaDocPreview<cr>
" Search for definition/usage
nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
nnoremap <silent> <buffer> <Space> :JavaDocPreview<cr>
" Toggle a breakpoint on the current line
nnoremap <silent> <buffer> <Tab><cr> :JavaDebugBreakpointToggle<cr>
" Step over, in, return
nnoremap <silent> <buffer> <leader>o :JavaDebugStep over<cr>
nnoremap <silent> <buffer> <leader>n :JavaDebugStep into<cr>
nnoremap <silent> <buffer> <leader>r :JavaDebugStep over<cr>

" Now fold everything but the top level class and comments.
"call ToggleJavaCommentsFold()
"setlocal foldlevel=1

" Clear up whitespace on save
autocmd BufWritePre <buffer> StripWhitespace
