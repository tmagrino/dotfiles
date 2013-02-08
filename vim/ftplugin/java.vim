setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=2
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

" Now fold everything but the top level class and comments.
call ToggleJavaCommentsFold()
setlocal foldlevel=1
