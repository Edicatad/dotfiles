" Globals
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'

" Ripgrep everything
command! -bang -nargs=* Ripgrep
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --ignore-case '.<q-args>, 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

command! -bang -nargs=* Rg
            \ execute "Ripgrep"<bang> . " " . shellescape(<q-args>)

" Toggle markdown notes
command! -nargs=0 NotesToggle call <sid>toggleNotes()
