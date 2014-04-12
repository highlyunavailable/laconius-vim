if has("gui_running")
  if has("autocmd")
    " Automatically resize splits when resizing a GUI VIM window
    autocmd VimResized * wincmd =
  endif
endif
