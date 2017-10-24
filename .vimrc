map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
highlight clear

let @/='' 
set hlsearch
set nocompatible
set incsearch
set smartcase
set shm=I
set showmatch
set spelllang=en_us
set spellfile=~/.vim/spellfile.add

highlight clear SpellBad
highlight SpellBad cterm=underline

nnoremap <silent> <C-l> :nohl<CR><C-l>
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='100,<50,f1,\"500,/100,:100 

if has("autocmd")
aug vimrc
au!
" restore cursor position when the file has been read
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif
aug ENG
endif
" ========================================
" Vim plugin configuration
" ========================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'lervag/vimtex'
Plugin 'valloric/youcompleteme'
Plugin 'tenfyzhong/CompleteParameter.vim'

" All of the Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Put your non-Plugin stuff after this line
""""""""""""""""""""""""""""""""""""""""""""""""
let $PATH=$PATH . ':/usr/local/bin'

" ================ GUI =============================
syntax enable
set colorcolumn=120

autocmd VimResized * wincmd =  " auto equalize windows

set encoding=utf-8
set guifont=Sauce\ Code\ Powerline:h11

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" ================ Remove Trailing on Save =============
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,javascript,sql autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" ================ Auto Update .vimrc for All Vim server ===============
function! UpdateVimRC()
 for server in split(serverlist())
     call remote_send(server, '<Esc>:source $MYVIMRC<CR>')
 endfor
endfunction
augroup myvimrchooks
au!
autocmd bufwritepost .vimrc call UpdateVimRC()
augroup END

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Change leader to a comma
let mapleader=","

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

set linebreak    "Wrap lines at convenient points

" ================ Completion =======================
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set guioptions-=r
set guioptions-=L

" ================ NERDTree ==============
map <C-n> :NERDTreeToggle %<CR>

" ================ vim-airline ===========
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline#extensions#whitespace#enabled = 0


" ============= Window =================
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" ============= Session ================
let g:session_autosave = 'yes'

" =============== VimTex =============

let g:vimtex_quickfix_ignore_all_warnings = 1


" =============== YouCompleteMe =============
set completeopt-=preview  

nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>  
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>  
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>  

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'  
let g:ycm_confirm_extra_conf=0  
let g:ycm_cache_omnifunc=0  
let g:ycm_complete_in_comments=1  
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_error_symbol = '!!'
let g:ycm_warning_symbol = '>>'
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" =============== CompleteParameter =============
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif
