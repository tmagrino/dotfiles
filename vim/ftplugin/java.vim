setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=2
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
syntax clear javaDocComment
syn region javaDocComment start="/\*\*" end="\*/" keepend contains=javaCommentTitle,@javaHtml,javaDocTags,javaDocSeeTag,javaTodo,@Spell
setlocal foldmethod=syntax
setlocal foldlevel=1
