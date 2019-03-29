" svn.vim -- Subversion control system mappings
" Maintainer:	Jeff Pitblado <jpitblado@stata.com>
" Last Change:	29mar2019
" Version:	1.1.3

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
	let output = system(g:svn_command . " diff " . a:rev . " " . a:file)
	if v:shell_error
		let output = bufname("%") . " NOT UNDER VERSION CONTROL"
	endif

	" open/setup a new split
	if bufwinnr("__diff_output__") == -1
		split __diff_output__
		setlocal noswapfile
		setlocal filetype=diff
		setlocal buftype=nofile
	else
		sbuffer __diff_output__
		normal! ggdG
	endif

	" insert diff output
	call append(0, split(output, '\v\n'))
	normal! gg
endfunction

" svn#bdiff() -- figures out the earliest revision when the specified file
" existed, then calls svn#diff() using that revision.

function! svn#bdiff (file)
	let rev = system(g:svn_command . " log --quiet --stop-on-copy " .  a:file . " | grep '^r[0-9]* |' | tail -1 | awk '{printf $1}'")
	if v:shell_error
		call svn#diff("", a:file)
	else
		call svn#diff("-" . rev, a:file)
	endif
endfunction

" svn#log() -- Calls -svn log- and dumps the contents into a buffer named
" __log_output__.

function! svn#log (file)
	let output = system(g:svn_command . " log --stop-on-copy --verbose " . a:file)
	if v:shell_error
		let output = bufname("%") . " NOT UNDER VERSION CONTROL"
	endif

	" open/setup a new split
	if bufwinnr("__log_output__") == -1
		split __log_output__
	else
		sbuffer __log_output__
	endif

	normal! ggdG
	setlocal filetype=changelog
	setlocal buftype=nofile

	" insert log output
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

	" insert status output
	call append(line("."), split(output, '\v\n'))
endfunction

" end: svn.vim
