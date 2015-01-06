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

set omnifunc=syntaxcomplete#Complete

set guifont=consolas:h12

execute pathogen#infect()

syntax on
filetype on
filetype plugin indent on
filetype plugin on

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

let g:slime_target = "screen"

if has("gui_running")
    colorscheme solarized
else
    colorscheme koehler
endif


"Erlang settings
let g:erlangManPath = "/usr/local/opt/erlang/lib/erlang/man"

"Syntastic settings
let g:syntastic_check_on_open = 1


"fsharp settings
let g:fsharpbinding_debug = 1
let g:syntastic_enable_balloons = 1
"commentary settings
"autocmd FileType fsharp set commentstring=\\ %s
" let b:fsharp_buffer_changed = 0
" augroup fsharp_au
"    au!
"    au CursorHold *.fs,*.fsi,*.fsx call OnCursorHold()
"    au TextChanged *.fs,*.fsi,*.fsx call OnTextChanged()
"    au TextChangedI *.fs,*.fsi,*.fsx call OnTextChanged()
"    au BufEnter *.fs,*.fsi,*.fsx call OnBufEnter()
" augroup END

" function! OnBufEnter()
"     "is there a nice way to just set this for fsharp files?
"     set updatetime=750
" endfunction

" function! OnCursorHold()
"     if exists ("b:fsharp_buffer_changed") != 0 
"         if b:fsharp_buffer_changed == 1
"             exec "SyntasticCheck"
"         endif
"     endif
"     let b:fsharp_buffer_changed = 0
" endfunction

" function! OnTextChanged()
"     let b:fsharp_buffer_changed = 1
" endfunction
