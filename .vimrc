set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2
set laststatus=2
set number
set background=dark
set autowrite
"no wrapping please
set nowrap
set mouse=a
set omnifunc=syntaxcomplete#Complete
set hidden "dirty buffers
set hlsearch

set guifont=consolas:h12

execute pathogen#infect()

syntax on
filetype on
filetype plugin indent on
filetype plugin on

"supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<C-X><C-O>"

au BufNewFile,BufRead *.md,*.txt setlocal wrap
au BufNewFile,BufRead *.md,*.txt setlocal spell

let g:slime_target = "screen"

if has("gui_running")
    colorscheme solarized
else
    colorscheme desert
endif

autocmd BufNewFile,BufRead *.hs,*.lhs setlocal omnifunc=necoghc#omnifunc

"Erlang settings
let g:erlangManPath = "/usr/local/opt/erlang/lib/erlang/man"

"Syntastic settings
let g:syntastic_check_on_open = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["erlang"] }

"fsharp settings
let g:fsharpbinding_debug = 1
let g:fsharp_completion_helptext = 1
let g:fsharp_test_runner = "/Users/karlnilsson/code/util/testrunners/nunit-console.exe"

:command JsonFormat exec '%!python -m json.tool'

"dash
nmap <silent> <leader>q <Plug>DashSearch
vmap <silent> <leader>q <Plug>DashSearch
