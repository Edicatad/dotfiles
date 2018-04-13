" Add fzf to runtimepath
set rtp+=~/.dotfiles-tools/fzf
" And also for fecken mac
set rtp+=/usr/local/opt/fzf
" [Layout] Fzf uses the bottom 30% of the screen in vim
let g:fzf_layout = {'down': '30%'}
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
