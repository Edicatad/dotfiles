"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    else
        call cursor(1,1)
    endif
endfunction

" Toggle a markdown notes file in a fixed window on the right with f12
nnoremap <F12> :NotesToggle<cr>
command! -nargs=0 NotesToggle call <sid>toggleNotes()
function! s:toggleNotes() abort
    let winnr = bufwinnr("notes.md")
    if winnr > 0
        exec winnr . "wincmd c"
        return
    endif
    botright 100vs notes.md
    setl winfixwidth
    setl nonumber
    setl norelativenumber
    " hack to make nerdtree et al not split the window
    setl previewwindow
    " for some reason this doesnt get run automatically and the cursor 
    " position doesn't get set
    doautocmd bufreadpost %
    " normal zMzO
endfunction


