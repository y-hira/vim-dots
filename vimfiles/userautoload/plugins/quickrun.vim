"------------------------------
" quick run を vimproc で非同期処理するための設定
"

let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright 8sp",
\       "outputter/error/error" : "quickfix",
\       "outputter/error/success" : "buffer",
\       "ourputter" : "error",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60
\   },
\}

" plantuml
" let g:quickrun_config = {
" \   "plantuml" :{
" \       "type" : "plantuml"
" \   },
" \
" \   "plantuml" : {
" \       "command" : "plantuml",
" \       "exec" : "%c %s"
" \       "ourputter" : "null",
" \   },
" }

