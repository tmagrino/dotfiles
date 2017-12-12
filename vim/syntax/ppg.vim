" Vim syntax file
" Language:         PPG

" Adapted from the cup syntax file by Jon Siddle

" Quit when a syntax file was already loaded	{{{
if exists("b:current_syntax")
	finish
endif
"}}}

" Include java syntax {{{
if version >= 600
	runtime! syntax/java.vim
	unlet b:current_syntax
else
	so $VIMRUNTIME/syntax/java.vim
endif
"}}}

syn cluster ppgOptions contains=ppgDef,ppgClass,ppgTerm,ppgNonTerm,ppgNonTermDef,ppgVarLabel,ppgOperator,ppgCodeInclude,ppgComment,ppgActionCode

syn region ppgStart start="" end="" contains=@ppgOptions


syn match ppgTerm "\<[A-Z_]\+\>" contained
syn match ppgNonTerm "\<[a-z_]\+\>" contained
syn match ppgNonTermDef "^[a-z]\+\>" contained
syn match ppgClass "\<[A-Z][a-z]\+\>" contained

syn match ppgDef "^package.*$" contained
syn match ppgDef "^import.*$" contained
syn match ppgDef "^precedence left" contained
syn match ppgDef "^precedence right" contained
syn match ppgDef "^precedence nonassoc" contained
syn match ppgDef "^terminal" contained
syn match ppgDef "^non terminal" contained

syn region ppgVarLabel matchgroup=ppgVarLabelMark start=":" end="\s" contains=ppgVar contained
syn match ppgVar "[a-z]\+\>" contained

syn match ppgOperator "::=" contained

syn region ppgCodeInclude matchgroup=ppgCodeIncludeMark start="^parser code {:" end=":}" contains=@javaTop contained
syn region ppgCodeInclude matchgroup=ppgCodeIncludeMark start="^action code {:" end=":}" contains=@javaTop contained
syn region ppgCodeInclude matchgroup=ppgCodeIncludeMark start="^init code {:" end=":}" contains=@javaTop contained

" take out comments
syn match ppgComment "//.*" contained
syn region ppgComment start="/\*" end="\*/" contained contains=ppgComment

" action code (only after states braces and macro use)
syn region ppgActionCode matchgroup=Delimiter start="{:" end=":}" contained contains=@javaTop,ppgJavaBraces

" keep braces in actions balanced
syn region ppgJavaBraces start="{" end="}" contained contains=@javaTop,ppgJavaBraces

" syncing
syn sync clear
syn sync minlines=10

" highlighting
hi link ppgOption      Special
hi link ppgMacroIdent  Ident
hi link ppgOptionError Error
hi link ppgComment     Comment
hi link ppgOperator    Operator
hi link ppgRuleStates  Special
hi link ppgDef      Keyword
hi link ppgTerm      Macro
hi link ppgNonTermDef      Typedef
hi link ppgNonTerm      Function
hi link ppgVar      Label
hi link ppgClass      Type
" hi ppgSectionSep guifg=yellow ctermfg=yellow guibg=blue ctermbg=blue gui=bold cterm=bold
hi link ppgCodeIncludeMark Delimiter

let b:current_syntax="ppg"
