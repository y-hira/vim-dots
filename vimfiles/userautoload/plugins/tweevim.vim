" The prefix key.
nnoremap    [tweetvim]   <Nop>
nmap    <leader>t [tweetvim]

nnoremap <silent> [tweetvim]t  :TweetVimSay<CR>
nnoremap <silent> [tweetvim]h  :TweetVimHomeTimeline<CR>

" For unite
nnoremap <silent> [unite]ta  :Unite tweetvim/account<CR>
