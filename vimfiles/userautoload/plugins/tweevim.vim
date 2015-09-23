" The prefix key.
nnoremap    [tweetvim]   <Nop>
nmap    <leader>t [tweetvim]

nnoremap [tweetvim]t  :<C-u>TweetVimSay<space>
nnoremap [tweetvim]s  :<C-u>TweetVimCommandSay<CR>
nnoremap [tweetvim]a  :<C-u>TweetVimSwitchAccount<space>
nnoremap <silent> [tweetvim]h  :<C-u>TweetVimHomeTimeline<CR>
nnoremap <silent> [tweetvim]m  :<C-u>TweetVimHomeMentions<CR>

" For unite
nnoremap <silent> [unite]ta  :Unite tweetvim/account<CR>
