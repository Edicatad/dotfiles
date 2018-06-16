"   Functional module for vimrc
" Idea behind this file is that because I can't have my mappings and commands 
" all in separate files I'm just gonna put all the functional stuff in a 
" separate file for clarity.

" Functions {{{
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

" Get the visual selection for a command (ie Rg)
function! VisualSelection()
    if mode()=="v"
        let [line_start, column_start] = getpos("v")[1:2]
        let [line_end, column_end] = getpos(".")[1:2]
    else
        let [line_start, column_start] = getpos("'<")[1:2]
        let [line_end, column_end] = getpos("'>")[1:2]
    end
    if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
        let [line_start, column_start, line_end, column_end] =
                    \   [line_end, column_end, line_start, column_start]
    end
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - 1]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction
" }}}

" Commands {{{
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
" }}}

" Mappings {{{
"   Disable normal space functionality
nnoremap <SPACE> <Nop>
"   Use it as a leader for keybinds
let mapleader=" "
"   Clear search
nnoremap <silent> <leader>/ :nohlsearch<CR>
nnoremap <leader><space> za
"   Pandoc
nmap <Leader>pc :RunSilent pandoc -o /tmp/vim-pandoc-out.html %<CR>
nmap <Leader>pp :RunSilent open /tmp/vim-pandoc-out.html<CR>
"   Markdown notes
nnoremap <F12> :NotesToggle<cr>
"   Git Fugitive
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gw :Gwrite<cr>
nnoremap <Leader>gc :Gcommit<cr>
nnoremap <Leader>gp :Git push origin 
"   Ripgrep
nnoremap <leader>ra :Rg<cr>
   
"   FZF
if executable("fzf")
    nnoremap <leader>ff :Files<cr>
    nnoremap <leader>fb :Buffer<cr>
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
