call plug#begin('~/.local/share/nvim/plugged')
"Plug 'davidhalter/jedi-vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi'
"Plug 'sbdchd/neoformat'
"Plug 'tmhedberg/SimpylFold'
"""" Python IDE
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'ludovicchabant/vim-gutentags'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neomake/neomake'
Plug 'janko-m/vim-test'
Plug 'alfredodeza/coveragepy.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'tpope/vim-abolish'


"Plug 'google/vim-maktaba'
"Plug 'google/vim-coverage'
"Plug 'google/vim-glaive'
"
"""" Tools
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-repeat'
Plug 'romainl/vim-qf'


"""" UI
"Plug 'bling/vim-bufferline'
"Plug 'pacha/vem-statusline'
"Plug 'pacha/vem-tabline'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'
Plug 'nathanaelkane/vim-indent-guides'

Plug 'scrooloose/nerdtree'

"""" Behaviour
Plug 'andymass/vim-matchup'
Plug 'cohama/lexima.vim'
Plug 'scrooloose/nerdcommenter'

"""" color themes
Plug 'ajgrf/sprinkles'
Plug 'rakr/vim-one'
Plug 'NLKNguyen/papercolor-theme'
call plug#end()

nnoremap <F5> :UndotreeToggle<cr>

let test#strategy = "neomake"
let test#python#runner = 'pytest'
augroup test
  autocmd!
  autocmd BufWrite * if test#exists() |
    \   TestFile |
    \ endif
augroup END
let g:neomake_open_list = 2

set number
set list

" COC
set hidden
set cmdheight=2
set updatetime=200
set shortmess+=c
set signcolumn=yes
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

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

let g:coveragepy_uncovered_sign = '⌦'


command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=? Lint :CocList diagnostics

set completeopt=menuone,preview
set previewheight=4
set pumheight=12
set showfulltag

" Lint
let g:neomake_python_enabled_makers = ['pylint']
call neomake#configure#automake('w')
nmap <silent> gn :NeomakeNextLoclist<Cr>
nmap <silent> gp :NeomakePrevLoclist<Cr>


nmap <silent><C-k><C-k> :b#<Cr>
nmap <silent><C-k> :CtrlPMixed<Cr>
nmap <silent><C-p> :CtrlPTag<Cr>
let g:ctrlp_reuse_window = 'quickfix'
let g:ctrlp_prompt_mappings = {
        \ 'PrtSelectMove("k")': ['<c-k>', '<up>', '<tab>']
        \}

set mouse=a

"Code folding
set foldmethod=manual

"Tabs and spacing
set autoindent
set cindent
set tabstop=4
set expandtab
set shiftwidth=4
set smarttab


" Completion
"let g:deoplete#enable_at_startup = 1
""" tab do go through completion
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
""" close preview automatically
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Alignment
"let g:neoformat_basic_format_align = 1
"let g:neoformat_basic_format_retab = 1
"let g:neoformat_basic_format_trim = 1

" JEDI
"let g:jedi#completions_enabled = 0
"let g:jedi#use_splits_not_buffers = "right"

" Themes
set background=light
set t_Co=256
let g:allow_italic = 1
colorscheme PaperColor
let g:airline#theme = 'papercolor'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols = {}
let g:airline_symbols.crypt = '◎'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

set showtabline=2


let g:highlightedyank_highlight_duration = 250

map <F3> :NERDTreeFocus<CR>
let NERDTreeIgnore=['__pycache__', '.*\.egg-info']
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

