call plug#begin()

" A fuzzy file finder
Plug 'kien/ctrlp.vim'
" Comment/Uncomment tool
Plug 'scrooloose/nerdcommenter'
" Switch to the begining and the end of a block by pressing %
Plug 'tmhedberg/matchit'
" A Tree-like side bar for better navigation
Plug 'scrooloose/nerdtree'
" A cool status bar
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'
" Nord
Plug 'arcticicestudio/nord-vim'
" Better syntax-highlighting for filetypes in vim
Plug 'sheerun/vim-polyglot'
" Intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Interactive Python buffers
Plug 'metakirby5/codi.vim'
" Git integration
Plug 'tpope/vim-fugitive'
" Auto-close braces and scopes
Plug 'jiangmiao/auto-pairs'

Plug 'rakr/vim-one'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'flazz/vim-colorschemes'

call plug#end()


set number
set list
set mouse=a
set signcolumn=yes

filetype plugin indent on
syntax on


" Completion with tab and space
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? 
      \   coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Code action on <leader>a
vmap <leader>a <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a <Plug>(coc-codeaction-selected)<CR>

" Remap for rename
nmap <leader>rn <Plug>(coc-rename)

" Format action on <leader>f
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
vmap <leader>F  <Plug>(coc-format-document)
nmap <leader>F  <Plug>(coc-format-document)

" Goto definition
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Open definition in a split window
nmap <silent> gv :split<CR><Plug>(coc-definition)<C-W>L


nmap <silent>gt :bn<Cr>
nmap <silent>gT :bp<Cr>
nmap <silent>g<Tab> :b#<Cr>
nmap <silent><A-1> :b 1<Cr>
nmap <silent><A-2> :b 2<Cr>
nmap <silent><A-3> :b 3<Cr>
nmap <silent><A-4> :b 4<Cr>
nmap <silent><A-5> :b 5<Cr>
nmap <silent><A-6> :b 6<Cr>
nmap <silent><A-7> :b 7<Cr>
nmap <silent><A-8> :b 8<Cr>
nmap <silent><A-9> :b 9<Cr>
nmap <silent><A-0> :b 10<Cr>

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=? Lint :CocList diagnostics


" Theme settings
set background=light
colorscheme PaperColor
set t_Co=256
let g:allow_italic = 1
let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1

set showtabline=2

" Nerd Tree
map <F3> :NERDTreeFocus<CR>
let NERDTreeIgnore=['__pycache__', '.*\.egg-info']

# remove whitespaces at the end of line
autocmd FileType py autocmd BufWritePre <buffer> %s/\s\+$//e
# organize imports
autocmd BufWritePre .* :call CocAction('runCommand', 'editor.action.organizeImport')

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
