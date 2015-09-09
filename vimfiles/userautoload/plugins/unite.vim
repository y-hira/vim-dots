" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]

" srart with insert mode
" let g:unite_enable_start_insert=1
 
" unite.vim keymap
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]bu :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]fm :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]dm :<C-u>Unite directory_mru<CR>
nnoremap <silent> [unite]rg :<C-u>Unite -buffer-name=register register<CR>
 
" vinarise
let g:vinarise_enable_auto_detect = 1
 
