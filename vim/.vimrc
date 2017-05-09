set nocompatible
filetype off
scriptencoding utf-8
set rtp+=~/.vim/bundle/Vundle.vim

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let g:mapleader=","

call vundle#begin()

Plugin 'FooSoft/vim-argwrap'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'benmills/vimux'
Plugin 'breard-r/vim-dnsserial'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'davidhalter/jedi-vim'
Plugin 'godlygeek/tabular'
Plugin 'grahamking/lintswitch'
Plugin 'kevints/vim-aurora-syntax'
Plugin 'mbbill/undotree'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'pantsbuild/vim-pants'
Plugin 'plasticboy/vim-markdown'
Plugin 'python-mode/python-mode'
Plugin 'rodjek/vim-puppet'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'tell-k/vim-autoflake'
Plugin 'tell-k/vim-autopep8'
Plugin 'thaerkh/vim-workspace'
Plugin 'tmhedberg/simpylfold'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-tbone'
Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set ruler
set laststatus=2

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on


" ================ Turn Off Swap Files ==============

"set noswapfile
"set nobackup
"set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" CULPRIT FOR 4 space indents!!! (shiftwidth=4)
" Next line sets back to two for Python
filetype indent plugin on
autocmd FileType python setl sw=2 sts=2 et

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

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


" ================ Custom Settings ========================
"so ~/.yadr/vim/settings.vim

set et ts=2 ai

autocmd BufNewFile,BufRead *.aurora set filetype=python
autocmd BufNewFile,BufRead BUILD set filetype=python
autocmd BufNewFile,BufRead AURORA set filetype=python
autocmd BufNewFile,BufRead *.jinja set filetype=jinja
autocmd BufNewFile,BufRead *.workflow set filetype=json
autocmd BufNewFile,BufRead **/squid**/*.conf* set filetype=squid

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

set rtp+=$HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim

python from powerline.vim import setup as powerline_setup
python powerline_setup
python del powerline_setup
set t_Co=256

let g:pymode_lint_checkers = ['mccabe', 'pyflakes', 'pylint', 'pep8', 'pep257']

let g:vim_markdown_preview_toggle=2

autocmd VimEnter * @b:last_tmux_window_name = system("tmux list-windows -a | ggrep -oP '(\S+)(?=\*)'")
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
autocmd VimLeave * call system("tmux rename-window " . expand("%last_tmux_window_name"))

autocmd FileType python map <buffer> <F3> :call Autoflake()<CR>
autocmd FileType python set colorcolumn=100
hi ColorColumn ctermbg=8

let g:pymode_lint_config = "$HOME/.pylintrc"

set background=dark
