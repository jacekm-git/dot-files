set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=4 shiftwidth=4      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
nnoremap <esc> :noh<return><esc>" disable highlighted search result after hitting space
"" Line numbers
set number
set relativenumber

""""""""""""""""""""""""""""""""""""""""
"" Plugin managment Vundle
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-commentary' 
Plugin 'scrooloose/nerdtree' 
Plugin 'bling/vim-airline'

call vundle#end()            " required
"""""""""""""""""""""""""""""""""""""""

filetype plugin indent on    " required
map gt :NERDTreeToggle<CR> " nerd tree toogle
map gr :browse oldfiles<CR> " recent files list 
map gb :buffers[!]<CR>:buffer<Space>
set hidden
set laststatus=2
