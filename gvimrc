"  1 important
"  2 moving around, searching and patterns
"  3 tags
"  4 displaying text
"  5 syntax, highlighting and spelling
"  6 multiple windows


"  7 multiple tab pages
"  8 terminal
"  9 using the mouse
" 10 GUI

" Set font
if has("gui_running")
  if has("gui_gtk2")
    " Ubuntu apt package : ttf-bitstream-vera
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
  elseif has("gui_win32")
    " TTF file: http://www.fontsquirrel.com/fonts/Bitstream-Vera-Sans-Mono
    set guifont=Bitstream_Vera_Sans_Mono:h10:cDEFAULT
  endif
endif
" 11 printing
" 12 messages and info
" 13 selecting text
" 14 editing text
" 15 tabs and indenting
" 16 folding
" 17 diff mode
" 18 mapping
" 19 reading and writing files
" 20 the swap file
" 21 command line editing
" 22 executing external commands
" 23 running make and jumping to errors
" 24 system specific
" 25 language specific
" 26 multi-byte characters
" 27 various
