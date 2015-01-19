" svn.vim -- Subversion control system mappings
" Maintainer:	Jeff Pitblado <jpitblado@stata.com>
" Last Change:	19jan2015
" Version:	1.1.1

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

nnoremap <leader>sbd :call svn#bdiff(bufname("%"))<cr>
nnoremap <leader>sbD :call svn#bdiff(".")<cr>

nnoremap <leader>sl :call svn#log(bufname("%"))<cr>
nnoremap <leader>sL :call svn#log(".")<cr>

nnoremap <leader>ss :call svn#status()<cr>

nnoremap <leader>sa :!svn add %<cr>
nnoremap <leader>sc :!svn commit %<cr>

" end: svn.vim
