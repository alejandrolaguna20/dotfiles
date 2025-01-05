" Vim configuration with vim-plug and vimtex

" Specify the directory for plugins
call plug#begin('~/.vim/plugged')

" Install vimtex for LaTeX support
Plug 'lervag/vimtex'

" Additional useful plugins (optional)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'

" End plugin section
call plug#end()

" General settings
filetype plugin indent on
syntax on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set encoding=utf-8
set termguicolors

" vimtex configuration
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_quickfix_mode = 0

" Fast navigation in LaTeX files
nmap <leader>lc :VimtexCompile<CR>
nmap <leader>lv :VimtexView<CR>
nmap <leader>le :VimtexErrors<CR>
nmap <leader>lt :VimtexTocToggle<CR>

" Enable conceal for LaTeX
let g:tex_conceal = 'abdmg'
set conceallevel=2

" Automatically open quickfix window on error
autocmd User VimtexEventCompileFailed cwindow

" NERDTree toggle
nmap <C-n> :NERDTreeToggle<CR>

" Lightline setup
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

colorscheme habamax
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","
" Install plugins if not already installed
autocmd VimEnter * if empty(glob('~/.vim/autoload/plug.vim')) |
      \   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      \   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |
      \   autocmd VimEnter * PlugInstall | 
      \ endif


