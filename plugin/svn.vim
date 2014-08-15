" svn.vim -- Subversion control system mappings
" Maintainer:	Jeff Pitblado <jpitblado@stata.com>
" Last Change:	15aug2014
" Version:	1.0.0

if exists("g:loaded_svn_vim")
  finish
endif
let g:loaded_svn_vim = 1

if !exists("g:svn_command")
	let g:svn_command = "svn"
endif

" maps ----------------------------------------------------------------------

nnoremap <leader>sd :call svn#diff("", bufname("%"))<cr>
nnoremap <leader>sD :call svn#diff("", ".")<cr>

nnoremap <leader>ss :call svn#status()<cr>

nnoremap <leader>sa :!svn add %<cr>

" end: svn.vim
