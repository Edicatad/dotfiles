" Maintainer:	Yri Davies	<0xdavy@gmail.com>
" Last change:	2017 Jun 26

" Misc {{{
set backspace=indent,eol,start  " allows backspace to remove indentation and stuff
set modelines=1                 " checks the last line of a file for mode changes
execute pathogen#infect()
" }}}
" Color scheme {{{
syntax enable		" enable syntax processing
colorscheme badwolf	" use the molokai colorscheme in ~/.vim/colors/
" }}}
" Deal with tabs {{{
set tabstop=4		" tabs are 4 spaces long when reading a file
set softtabstop=4	" tabs are 4 spaces long when editing (for backspace)
set expandtab		" tabs are inserted as spaces for things like bash
" }}}
" UI config {{{
set number		    " line numbers
"set relativenumber	" relative line numbers
set showcmd		    " shows the typed command bottom right
set cursorline		" highlight current line
filetype indent on	" opens indentation file based on detected filetype (.c, .py, etc)
set wildmenu		" visual autocomplete for commands
set wildmode=list:longest,list:full " more efficient autocomplete!
set lazyredraw		" only redraw when necessary
set showmatch		" highlight matching for brackets [{()}]
" }}}
" Search settings {{{
set incsearch		" search as you type
set hlsearch		" highlight matches
set ignorecase      " ignore case in searches
" }}}
" Folding {{{
set foldenable		    " enable this
set foldlevelstart=10	" open 10 levels of folds
set foldnestmax=10      " allow at most 10 nested folds
set foldmethod=indent   " fold based on indentation by default
nnoremap <space> za
" }}}
" Movement {{{
"nnoremap j gj		" These make up/down function visually, so they work on wrapped lines
"nnoremap k gk
nnoremap gV `[v`]	" highlight last inserted text
set scrolljump=5    " jump 5 lines when the cursor leaves the screen
set scrolloff=3     " keep 3 lines visible above and below the cursor at all times
" }}}
" TMUX workarounds {{{
if exists('$TMUX')  " change cursor mode to vertical bar in TMUX
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}} 
" Nerdtree {{{
autocmd vimenter * NERDTree     " start NERDTree when vim starts
autocmd vimenter * :wincmd l    " start in the file window rather than in NERDTree
" close NERDTree if it's the only screen left in vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}
" Back up stuff {{{
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
    set undodir=/tmp,.
  endif
  set backupdir=/tmp,.
  set directory=/tmp,.
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
