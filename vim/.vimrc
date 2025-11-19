" -----------------------------------------------------------------------------
" 1. PLUGINS (Vim-Plug)
" -----------------------------------------------------------------------------
" Auto-install vim-plug if missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Theme (Matching your Alacritty/Tmux/Zed)
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File Explorer
Plug 'preservim/nerdtree'

" Icons (Requires your FiraCode Nerd Font)
Plug 'ryanoasis/vim-devicons'

" Git integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Syntax Highlighting bundle
Plug 'sheerun/vim-polyglot'

call plug#end()

" -----------------------------------------------------------------------------
" 2. THEME & UI CONFIGURATION
" -----------------------------------------------------------------------------
set termguicolors           " Enable true colors
colorscheme catppuccin_mocha " Match your other config files

" Airline (Status Bar) Settings
let g:airline_theme = 'catppuccin_mocha'
let g:airline_powerline_fonts = 1 

" -----------------------------------------------------------------------------
" 3. SANE DEFAULTS
" -----------------------------------------------------------------------------
syntax on                   " Enable syntax highlighting
set number                  " Show line numbers
set relativenumber          " Show relative line numbers (good for jumps)
set mouse=a                 " Enable mouse support (scrolling/selection)
set clipboard=unnamedplus   " Share clipboard with OS (macOS/Linux)

" Indentation (Matches your Zed settings: tab_size 2)
set tabstop=2
set shiftwidth=2
set expandtab               " Use spaces instead of tabs
set autoindent
set smartindent

" Search
set ignorecase              " Case insensitive searching
set smartcase               " ...unless capital letters are used
set incsearch               " Incremental search
set hlsearch                " Highlight matches

" UX behavior
set scrolloff=8             " Keep 8 lines available when scrolling down
set signcolumn=yes          " Always show sign column (prevents text shifting)
set updatetime=100          " Faster completion/updates
set encoding=utf-8

" -----------------------------------------------------------------------------
" 4. KEY MAPPINGS
" -----------------------------------------------------------------------------
let mapleader = " "         " Set Space as leader key

" Clear search highlights with <Leader> + h
nnoremap <leader>h :nohlsearch<CR>

" Toggle NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Easy window navigation (Ctrl + h/j/k/l)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
