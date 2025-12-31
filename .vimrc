call plug#begin()

Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'rose-pine/vim'
Plug 'bkad/CamelCaseMotion'
Plug 'itchyny/lightline.vim'

call plug#end()

let g:lightline = { 'colorscheme': 'rosepine' }

set background=dark
let g:disable_bg = 1
colorscheme rosepine

set termguicolors
set mouse=a
syntax on
set novisualbell
set laststatus=2
set noshowmode
" set number relativenumber
" set nu rnu
set shiftwidth=4
set incsearch
set ignorecase
set smartcase

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-S-o> <C-i>
nnoremap J mzJ`z
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap <leader>p "_dP

let mapleader = " "
let g:camelcasemotion_key = '<leader>'

