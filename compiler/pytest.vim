" Vim compiler file
" Compiler:	Testing using Pytest for Python
" Maintainer:	kahlil hodgson <kahlil.hodgson999@gmail.coml>
" Last Change: 2020-02-16

if exists("current_compiler")
  finish
endif

let current_compiler = "pytest"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" Disable Python warnings
if !exists('$PYTHONWARNINGS')
  let $PYTHONWARNINGS="ignore"
endif

let s:cpo_save = &cpo
set cpo&vim
set cpo-=C

CompilerSet makeprg=pytest\ --tb=short\ -q

" Skip lines like the following:
"
" ============================ ERRORS ==========================================
" =========================== FAILURES =========================================
"     12 tests deselected
" WARNING: Coverage disabled via --no-cov switch!
"
CompilerSet efm  =%-G=%#\ ERRORS\ =%#,
CompilerSet efm +=%-G=%#\ FAILURES\ =%#,
CompilerSet efm +=%-G%\\s%\\*%\\d%\\+\ tests\ deselected%.%#,
CompilerSet efm +=%-GWARNING:\ Coverage\ disabled\ via\ --no-cov\ switch!

" A line begining with ERROR: is a stand-alone error
CompilerSet efm +=ERROR:\ %m,

" Test FAILURES are multi-line and begin with something like
" ________________________ test_parse_file _____________________________________
CompilerSet efm +=%E_%\\+\ %m\ _%\\+,

" If continuing, match a file/line specifier
CompilerSet efm +=%Cfile\ %f\\,\ line\ %l,    " old style
CompilerSet efm +=%C%f:%l:\ in\ %m,           " new style

" A leading E followed by one or more spaces indicates a message
CompilerSet efm +=%CE\ %#%m,

" This looks like something you might find in a traceback
CompilerSet efm +=%EE\ \ \ \ \ File\ \"%f\"\\,\ line\ %l,
CompilerSet efm +=%ZE\ \ \ %[%^\ ]%\\@=%m,

" File/line markers at the end of a multi-line error from the `-tb=short` option
CompilerSet efm +=%Z%f:%l:\ %m,
CompilerSet efm +=%Z%f:%l:,

" Continues with "anything" if we 
"  1. have already started a multiline (after matching an E)
"  2. haven't finished (before matching a Z)
CompilerSet efm +=%C%.%#,

" Skip any line containing ' seconds,'?
CompilerSet efm +=%-G%.%#\ seconds,

" Skip everything else
CompilerSet efm +=%-G%.%#,

let &cpo = s:cpo_save
unlet s:cpo_save

