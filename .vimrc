call plug#begin('~/.config/nvim/plugged')

" Plugins {
  " airline is a better status line and a tab-bar for nvim.
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " gruvbox colorscheme. Seems to work the best for me.
  Plug 'morhetz/gruvbox'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-vinegar'
  Plug 'tpope/vim-rhubarb'
  Plug 'neovim/nvim-lspconfig'
  Plug 'ervandew/supertab'
  Plug 'ntpeters/vim-better-whitespace'

  "
" }
"
call plug#end()

lua << EOF
local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'
local custom_lsp_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    -- See `:help nvim_buf_set_keymap()` for more information
    -- local opts =  {noremap = true, silent = true}
    local opts =  {noremap = true}
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- ... and other keymappings for LSP
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

    -- Use LSP as the handler for omnifunc.
    --    See `:help omnifunc` and `:help ins-completion` for more information.
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- For plugins
    -- require('completion').on_attach()
end
-- Check if it's already defined for when reloading this file.
-- if not lspconfig.erlangls then
-- configs.erlangls = {
--         default_config = {
--           cmd = {'erlang_ls'};
           --  filetypes = {'erlang'};
            -- root_dir = function(fname)
              -- return lspconfig.util.find_git_ancestor(fname) or fname
--             end;
--             settings = {},
--             on_attach = custom_lsp_attach
--             };
--         }
-- end
-- lspconfig.erlangls.setup{}

require'lspconfig'.erlangls.setup{
    on_attach = custom_lsp_attach
}

require'lspconfig'.fsautocomplete.setup{
    cmd = {'dotnet', '/Users/nkarl/bin/fsautocomplete.netcore/fsautocomplete.dll', '--background-service-enabled'};
    root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or fname
    end;
    on_attach = custom_lsp_attach
}
EOF


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

set hidden "dirty buffers
set hlsearch

set guifont=consolas:h12
set colorcolumn=80
set splitright
set splitbelow

set termguicolors


let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"execute pathogen#infect()
syntax on
filetype on
filetype plugin indent on
filetype plugin on

"supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<C-X><C-O>"

au BufNewFile,BufRead *.md,*.txt setlocal wrap
au BufNewFile,BufRead *.md,*.txt setlocal spell

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

autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp

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
" let g:syntastic_fsharp_checkers = ['syntax']
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_always_populate_loc_list = 1
"fsharp settings
let g:fsharp#linter = 0
" let g:fsharpbinding_debug = 1
" let g:fsharp_completion_helptext = 1
" let g:fsharp_test_runner = "/Users/karlnilsson/code/util/testrunners/nunit-console.exe"
let g:airline#extensions#branch#enabled = 0

" let g:LanguageClient_serverCommands = {
"   \ 'fsharp': g:fsharp#languageserver_command
"   \ }
"erlang

:command! JsonFormat exec '%!python -m json.tool'


set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

set exrc
set secure

" the old regex engine seems faster
" set re=1

function! ErlangCurrentFunction()
    let ln = search('^[a-z].*(', 'nb')
    if ln
        " extract function name from line
        let m = matchstr(getline(ln), '^.*\ze(')
        return m
    endif
endfunction

function! CtGmake(cmd)
    " assumes standard erlang.mk setup
    let ct_dir = expand('%:p:h:h')
    return "!gmake -C " . ct_dir . " " . a:cmd
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
    let cmd = "ct-" . suite_name . " t=" . b:ct_group . ":" . current_function "SKIP_DEPS=true"
    return CtGmake(cmd)
endfunction

function! ErlangCt(...)
    if a:0
        " we have passed an argument and is running part of a suite
        " (group:test)
        echom "we have an argment" a:1
        let cmd = "ct-" . ErlangSuiteName() . " t=" . a:1 "SKIP_DEPS=true"
        return CtGmake(cmd)
    else
        " run the whole suite
        let cmd  = "ct-" . ErlangSuiteName() "SKIP_DEPS=true"
        return CtGmake(cmd)
    endif
endfunction

"run all eunit tests in the current buffer
command! Eunit execute "!gmake eunit EUNIT_MODS=\\'" . expand('%:t:r') . "\\' SKIP_DEPS=true"
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
