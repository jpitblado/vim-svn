" svn.vim -- Subversion control system mappings
" Maintainer:	Jeff Pitblado <jpitblado@stata.com>
" Last Change:	15aug2014
" Version:	1.0.0

if exists("g:autoloaded_svn_vim")
  finish
endif
let g:autoloaded_svn_vim = 1

if !exists("g:svn_command")
	let g:svn_command = "svn"
endif

" functions -----------------------------------------------------------------

" svn#diff() -- Calls -svn diff- and dumps the contents into a buffer named
" __diff_output__.

function! svn#diff (rev, file)
	let output = system(g:svn_command . " diff " . " " . a:rev . " " . a:file)
	if v:shell_error
		let output = bufname("%") . " NOT UNDER VERSION CONTROL"
	endif

	" open/setup a new split
	if bufwinnr("__diff_output__") == -1
		split __diff_output__
	else
		sbuffer __diff_output__
	endif

	normal! ggdG
	setlocal filetype=diff
	setlocal buftype=nofile

	" insert diff output
	call append(0, split(output, '\v\n'))
	normal! gg
endfunction

" svn#status() -- Calls -svn status- and dumps the contents into the current
" buffer.

function! svn#status ()
	let output = system(g:svn_command . " status")
	if v:shell_error
		let output = bufname("%") . " NOT UNDER VERSION CONTROL"
	endif

	" insert diff output
	call append(line("."), split(output, '\v\n'))
endfunction

" end: svn.vim
