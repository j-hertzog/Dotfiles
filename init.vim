" ############## "
" ####Basics#### "
" ############## "

syntax on
set nocompatible
set smartcase
filetype plugin on
set background=dark
set rnu
set guicursor=i:block
set cursorline
set confirm
set tabstop=4 shiftwidth=4 expandtab
autocmd BufRead,BufNewFile *.md setlocal textwidth=80 nonu
autocmd BufRead,BufNewFile  *.ts* setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile  *.js* setlocal ts=2 sw=2 expandtab
autocmd BufRead,BufNewFile  *.*css setlocal ts=2 sw=2 expandtab
highlight VertSplit cterm=NONE
set fillchars+=vert:\▏

" spell check
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

" Enable dictionary auto-completion in Markdown files and Git Commit Messages
autocmd FileType markdown setlocal complete+=kspell
autocmd FileType gitcommit setlocal complete+=kspell

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" ############## "
" ###Mappings### "
" ############## "

let mapleader="\<Space>"

" indent without losing the visual selection
xnoremap < <gv
xnoremap > >gv

nnoremap <leader>gb :Blame<CR>
nnoremap <leader>gy :Goyo<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>aq :wqa<CR>

" insert space without leaving normal
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

"clipboard copy with leader
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"navigate buf with [tab] and bp with [shift+tab]
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

"GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"jump to errors in llist
nnoremap <Leader>jj :call CocAction('diagnosticNext')<CR>
nnoremap <Leader>kk :call CocAction('diagnosticPrevious')<CR>

nnoremap <Leader>m :make<CR>

"shift + k opens up documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

"clear search highlighting until next search
nmap <Leader>/ :noh<CR>

"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <silent> <Leader>s <Plug>SearchNormal
vmap <silent> <Leader>s <Plug>SearchVisual

"uppercase word after cursor in insert mode
imap <c-u> <esc>veU<esc>ea


" ############# "
" ###Plugins### "
" ############# "

let g:ale_disable_lsp = 1
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'preservim/vimux'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank']
call plug#end()

" ############### "
" #PluginConfigs# "
" ############### "

colorscheme PaperColor

let g:airline_theme='purify'
let g:airline_theme='bubblegum'

let g:vimwiki_folding = 'expr'

" vimux pane height
let g:VimuxHeight = "30"

" set max width of Goyo 
let g:goyo_width = 90
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


" disable git gutter in markdown files (laggy)
autocmd BufRead,BufNewFile  *.md GitGutterDisable | set nowrap 

nmap <C-p> :cn<CR>
nmap <C-n> :cp<CR>

nmap <C-j> <Plug>VimwikiNextLink
nmap <C-k> <Plug>VimwikiPrevLink

" all about git
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)
nmap <leader>ga <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
nnoremap <leader>gs :Magit<CR>
nnoremap <leader>gP :! git push<CR>

"custom icons for ale
let g:ale_sign_error = '✖'
let g:ale_sign_warning = "⚠"

highlight ALEError cterm=underline ctermfg=196 gui=underline guifg=#FF875F
highlight ALEErrorSign ctermbg=NONE ctermfg=196
highlight ALEWarning cterm=underline gui=underline ctermfg=208 guifg=#fed8b1
highlight ALEWarningSign ctermbg=NONE ctermfg=208
"let g:ale_linters = {'php': ['php', 'langserver', 'phan']}
let g:ale_linters = { 'c++': ['clang', 'g++'], 'c': ['clang'], 'h': ['null']}

" custom setting for clangformat
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4}"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

"coc config
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

"run autograder for 360 to check assignment grade
nnoremap <leader>vr :call VimuxRunCommand("clear; python autograder.py;")<CR>
nnoremap <leader>vp :call VimuxPromptCommand("clear; python autograder.py -q q")<CR>
nnoremap <leader>vq :call VimuxCloseRunner()<CR>

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ############# " 
" ##Functions## "
" ############# "

command! -nargs=* Blame call s:GitBlame()
function! s:GitBlame()
    let cmd = "git blame -w " . bufname("%")
    let nline = line(".") + 1
    botright new
    execute "$read !" . cmd
    execute "normal " . nline . "gg"
    execute "set filetype=perl" 
endfunction

"Absolute path of open file to clipboard
function! Ptc()
    let @+=expand('%:p')
endfunction
command! Ptc call Ptc()

"ex) :Tag h1
function! Tag(name)
    let @"="<" . a:name . "></" . a:name . ">"
    normal! pbbl
    startinsert
endfunction
command! -nargs=1 Tag call Tag(<f-args>)

"ex) :Jtag HelloWorld
function! Jtag(name)
    let @"="<" . a:name . " />"
    normal! pb
    startinsert
endfunction
command! -nargs=1 Jtag call Jtag(<f-args>)

highlight Search ctermfg=39
highlight Search ctermbg=212
nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>

" Damian Conway's Die Blinkënmatchen: highlight matches
function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
  call matchdelete(ring)
  redraw
endfunction

" switch between last two buffers
nnoremap <leader><leader> <c-^>

" completes task and adds timestamp
nnoremap <leader>tt :call GetTOD()<CR>
function! GetTOD()
    "substitute removes extra escape character spawned by time-of-day
    let tod=substitute(system('date +%I:%M%p'), '\n$', '', '')
    " removes initial * [ ] on a to-do item
    let split_line=split(getline('.'), "] ")[1]
    " marks as complete and adds the timestamp and saved line
    call setline(line('.'), '* [X] | ' . tod . ' | ' . split_line)
endfunction

" create a new day for journal entry
nnoremap <leader>je :call JournalEntry()<CR>
function! JournalEntry()
    let entry=substitute(system('date +%A\ %I:%M\ %x'), '\n$', '', '')
    call setline(line('.'), '#### ' . entry . ' ####')
endfunction

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "rust"},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
