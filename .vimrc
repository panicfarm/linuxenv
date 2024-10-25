set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab number autoread
set hidden " allow unsaved files to be open in background
highlight Comment ctermfg=2
"" plugins

filetype plugin on " turn on filetype plugins

call plug#begin()

" language specific plugins
Plug 'racer-rust/vim-racer'     " rust autocomplete
Plug 'rust-lang/rust.vim'       " rust

" Plug 'dense-analysis/ale'       " js

" other plugins
Plug 'junegunn/fzf.vim'     " fzf fuzzy finder vim integration
Plug 'tpope/vim-commentary' " comment and uncomment operations

" fzf binary and runtime path files
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}

call plug#end()


let g:racer_experimental_completer = 1 " show complete signature
let g:racer_insert_paren           = 1 " insert parenthesis into completion
let g:rust_recommended_style       = 0 " disable shiftwidth and tabstop=4 enforced by rust plugin. These will be controlled by rustfmt.toml 

" recursive mappings
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

nnoremap <c-k> :AllLines<cr>| " search all lines in all files
nnoremap <c-p> :Files<cr>|    " search files by name

" commands
command! -bang -nargs=* AllLines
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({'options': ['--delimiter=:', '--nth=4..']}), <bang>0)

" fix colors in rust.vim
" compiler errors highlighting
highlight SpellBad term=reverse ctermbg=7 

" on save, auto-format rust
au BufWritePost *.rs silent exec "!cargo fmt 2>/dev/null"

" otherwise long js files are not highlighted
au BufEnter *.{js,html} :syntax sync fromstart
