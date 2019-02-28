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
set colorcolumn=80
set splitright
set splitbelow

set termguicolors


set cm=blowfish2

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

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

let g:airline_powerline_fonts = 1

if has("gui_running")
    colorscheme solarized
elseif &diff
    colorscheme blue
else
    colorscheme gruvbox
    let g:gruvbox_italic=1
    let g:gruvbox_contrast_dark='hard'
endif

autocmd BufNewFile,BufRead *.hs,*.lhs setlocal omnifunc=necoghc#omnifunc
" enable ejs support
au BufNewFile,BufRead *.ejs set filetype=html

let g:OmniSharp_server_type = 'roslyn'

"Erlang settings
let g:erlangManPath = "/usr/local/opt/erlang/lib/erlang/man"

let g:erlang_tags_ignore = ['_rel', 'rel']

"Syntastic settings
let g:syntastic_elixir_checkers = ['elixir']
let g:syntastic_enable_elixir_checker = 1
let g:syntastic_elixir_elixir_args = '+elixirc'
let g:syntastic_check_on_open = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["erlang"] }
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
let g:syntastic_fsharp_checkers = ['syntax']
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_always_populate_loc_list = 1
"fsharp settings
let g:fsharpbinding_debug = 1
let g:fsharp_completion_helptext = 1
let g:fsharp_test_runner = "/Users/karlnilsson/code/util/testrunners/nunit-console.exe"
let g:airline#extensions#branch#enabled = 0

"erlang

:command! JsonFormat exec '%!python -m json.tool'

"dash
nmap <silent> <leader>q <Plug>DashSearch
vmap <silent> <leader>q <Plug>DashSearch

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

set exrc
set secure

" the old regex engine seems faster
set re=1

function! ErlangCurrentFunction()
    let ln = search('^[a-z].*(', 'nb')
    if ln
        " extract function name from line
        let m = matchstr(getline(ln), '^.*\ze(')
        return m
    endif
endfunction

function! ErlangSuiteName()
    let suite_name = substitute(expand('%:t:r'), '_SUITE', '', '')
    return suite_name
endfunction

function! ErlangCtCurrentEx()
    if !exists("b:ct_group")
        let b:ct_group = input('Enter Ct Group: ')
    endif
    let suite_name = ErlangSuiteName()
    let current_function = ErlangCurrentFunction()
    let tail = suite_name . " t=" . b:ct_group . ":" . current_function "SKIP_DEPS=true"
    return "make! ct-" . tail
endfunction

function! ErlangCt(...)
    if a:0
        " we have passed an argument and is running part of a suite
        " (group:test)
        echom "we have an argment" a:1
        return "make! ct-" . ErlangSuiteName() . " t=" . a:1 "SKIP_DEPS=true"
    else
        " run the whole suite
        return "make! ct-" . ErlangSuiteName() "SKIP_DEPS=true"
    endif
endfunction

"run all eunit tests in the current buffer
command! Eunit execute "make! eunit EUNIT_MODS=\\'" . expand('%:t:r') . "\\' SKIP_DEPS=true"
"run entire common test suite if no arguments are provided
"or runs specific common test group:test with a single argument
command! -nargs=? Ct execute ErlangCt(<q-args>)
" try to execute the current function as a Ct test
command! CtCur execute ErlangCtCurrentEx()

command! Profile execute "profile start prof.log | profile func * | profile file *"

augroup erlang_commands
    autocmd Filetype erlang nnoremap <buffer> <leader>e :Eunit<cr>
    autocmd Filetype erlang nnoremap <buffer> <leader>c :CtCur<cr>
augroup END

" TLA+
command! PcalTrans execute "!java -cp ~/tla pcal.trans " . expand('%')
command! TLCModelCheck execute "!java tlc2.TLC -modelcheck " . expand('%')
