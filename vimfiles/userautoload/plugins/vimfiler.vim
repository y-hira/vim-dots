let g:vimfiler_as_default_explorer=1

" The prefix key
nnoremap    [vimfiler]   <Nop>
nmap    <space>f [vimfiler]

" vimfiler keymap
nnoremap <silent> [vimfiler]b :<C-u>VimFilerBufferDir<CR>
nnoremap <silent> [vimfiler]c :<C-u>VimFilerCurrentDir<CR>
nnoremap <silent> [vimfiler]e :<C-u>VimFilerExplorer<CR>
