" Maintainer:   Yri Davies  <0xdavy@gmail.com>
" Last change:  2017 Jun 26

" Variables and arrays {{{
let g:currentmode={
            \ 'n'  : 'Normal',
            \ 'no' : 'N·Operator Pending',
            \ 'v'  : 'Visual',
            \ 'V'  : 'V·Line',
            \ ''  : 'V·Block',
            \ 's'  : 'Select',
            \ 'S'  : 'S·Line',
            \ ''  : 'S·Block',
            \ 'i'  : 'Insert',
            \ 'R'  : 'Replace',
            \ 'Rv' : 'V·Replace',
            \ 'c'  : 'Command',
            \ 'cv' : 'Vim Ex',
            \ 'ce' : 'Ex',
            \ 'r'  : 'Prompt',
            \ 'rm' : 'More',
            \ 'r?' : 'Confirm',
            \ '!'  : 'Shell',
            \}

" }}}
" Plugins & external programs{{{
execute pathogen#infect()

" Fzf {{{
if executable("fzf")
    " Source fzf settings file
    source ~/.vim/plugins/fzf.vim
endif
" }}}
" Netrw {{{
" .vim/plugin/netrw.vim
" this is set up for a nerdtree style pane on the left side
" and p shows a preview in a vertical split
let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_preview = 1
" source: https://www.reddit.com/r/vim/comments/83y4y4/antipatterns_what_not_to_do/dw8ycxi/
" }}}
" Ripgrep {{{
if executable("rg")
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}
" Dispatch{{{
autocmd BufReadPost *
      \ if getline(1) =~# '^#!' |
      \   let b:dispatch =
      \       matchstr(getline(1), '#!\%(/usr/bin/env \+\)\=\zs.*') . ' %' |
      \   let b:start = '-wait=always ' . b:dispatch |
      \ endif
autocmd FileType scss,javascript let b:dispatch = 'npm run dev'
" }}}
" Gutentags{{{
" Where does it generate tags
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.vim/tags')
" When does it generate new files
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
" Exclude certain filetypes from tag generation
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]
" }}}
" neomake {{{
let g:neomake_php_phpcs_exe = './vendor/bin/phpcs'
let g:neomake_php_phpcs_args_standard = 'ruleset.xml'
let g:neomake_place_signs = 1
let g:neomake_error_sign = {
            \ 'text': 'X',
            \ 'texthl': 'NeomakeErrorSign',
            \ }
let g:neomake_warning_sign = {
            \   'text': '!',
            \   'texthl': 'NeomakeWarningSign',
            \ }
let g:neomake_message_sign = {
            \   'text': '>',
            \   'texthl': 'NeomakeMessageSign',
            \ }
let g:neomake_info_sign = {
            \ 'text': 'i',
            \ 'texthl': 'NeomakeInfoSign'
            \ }
" Automatically neomake stuff on writing or a second after normal mode changes
" stop
call neomake#configure#automake('nw', 1000)
" }}}
" }}}
" Color scheme {{{
syntax enable           " enable syntax processing
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif
highlight VertSplit ctermfg=bg ctermbg=18
highlight ColorColumn ctermbg=bg
" Better highlighting for bad spelling and (more importantly) neomake
highlight SpellBad ctermfg=bg ctermbg=17
" Filetype specific settings for syntax highlighting and shit
autocmd BufRead,BufNewFile *.vue setfiletype html
" }}}
" Indentation {{{
" General indentation rules
set tabstop=4       " tabs are 4 spaces long when reading a file
set softtabstop=4   " tabs are 4 spaces long when editing (for backspace)
set shiftwidth=4    " expanded tabs are 4 spaces long
set expandtab       " tabs are inserted as spaces for things like bash
set smarttab        " tab key brings you to the next tabstop multiple rather than hard-inserting four spaces
set copyindent      " copy indentation from previous line
" Filetype-specific indentation rules
autocmd FileType html setlocal shiftwidth=2 tabstop=2
" }}}
" UI config {{{
set backspace=indent,eol,start  " allows backspace to remove indentation and stuff
set modelines=1                 " checks the last line of a file for mode changes
set number          " line numbers
set relativenumber  " Show relative numbers for lines
set showmode        " Show the current mode
set showcmd         " shows the typed command bottom right
set cursorline      " highlight current line
set cursorcolumn    " highlight current column
filetype indent on  " opens indentation file based on detected filetype (.c, .py, etc)
set wildmenu        " visual autocomplete for commands
set wildmode=list:longest,list:full " more efficient autocomplete!
set lazyredraw      " only redraw when necessary
set showmatch       " highlight matching for brackets [{()}]
set mouse=a         " Allow mouse interaction in all modes
set showbreak=↪\ 
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set fillchars=vert:\ 
augroup CursorIndicatorsInActiveWindowOnly
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    autocmd WinLeave * setlocal nocursorline
    autocmd WinLeave * setlocal nocursorcolumn
augroup END
augroup ColorcolumnOnlyInInsertMode
    autocmd!
    autocmd InsertEnter * setlocal colorcolumn=81
    autocmd InsertLeave * setlocal colorcolumn=0
augroup END
" }}}
" Status line {{{
" Base statusline
hi User1 ctermfg=8 ctermbg=18
" Column number
hi User2 ctermfg=2 ctermbg=0
" File name
hi User3 ctermfg=0 ctermbg=3
" Warnings
hi User4 ctermfg=1 ctermbg=18
" Git
hi User5 ctermfg=4 ctermbg=18
" Mode
hi User6 ctermfg=0 ctermbg=17

set statusline =

set statusline+=%2*
set statusline+=%3c\     "Column number
set statusline+=%1*

set statusline+=%1*\ 
set statusline+=%3*
set statusline+=\ %<    " Truncate here
set statusline+=%f\     "tail of the filename
set statusline+=%h      "help file flag
set statusline+=%y\     "filetype
set statusline+=%1*

" Status line for vim-fugitive
set statusline+=%5*
set statusline+=\ %{fugitive#statusline()}\ 
set statusline+=%1*

"display a warning if fileformat isnt unix
set statusline+=%4*
set statusline+=%{&ff!='unix'?'\ ['.&ff.']\ ':''}
set statusline+=%1*

"display a warning if file encoding isnt utf-8
set statusline+=%4*
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'\ ['.&fenc.']\ ':''}
set statusline+=%1*

"read only flag
set statusline+=%4*
set statusline+=%r
set statusline+=%1*

"modified flag
set statusline+=%4*
set statusline+=%m
set statusline+=%1*

" Screen side marker, everything below this is on the right
set statusline+=%=

" Vim mode, verbose
set statusline+=%6*
set statusline+=\ %{g:currentmode[mode()]}\ 
set statusline+=%1*\ 

set laststatus=2        " always show the status line

" }}}
" Search settings {{{
set incsearch       " search as you type
set hlsearch        " highlight matches
set ignorecase      " ignore case in searches
set smartcase       " respect case if you type it
" }}}
" Folding {{{
set foldenable          " enable this
set foldlevelstart=10   " open 10 levels of folds
set foldnestmax=10      " allow at most 10 nested folds
set foldmethod=indent   " fold based on indentation by default
" }}}
" Movement {{{
set scrolljump=5    " jump 5 lines when the cursor leaves the screen
set scrolloff=15    " keep 15 lines visible above and below the cursor at all times
" }}}
" Functional module {{{
if filereadable(expand("\~/.vim/functional.vim"))
    source \~/.vim/functional.vim
endif
" }}}
" Back up stuff {{{
if has("vms")
    set nobackup      " do not keep a backup file, use versions instead
else
    set backup        " keep a backup file (restore to previous version)
    set backupdir=/tmp,.
    set directory=/tmp,.
    if has('persistent_undo')
        set undofile    " keep an undo file (undo changes after closing)
        set undodir=/tmp,.
    endif
endif
" }}}
" OS-specific stuff {{{
if has ('unix')
    if has ('osx')  " OSX
        source ~/.vim/mac-specific.vim
    else            " Linux etc
        source ~/.vim/linux-specific.vim
    endif
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
