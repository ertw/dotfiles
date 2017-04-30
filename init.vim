call plug#begin('~/.vim/plugged')
"Plug 'fsharp/vim-fsharp', {
"      \ 'for': 'fsharp',
"      \ 'do':  'make fsautocomplete',
"      \}
"Plug 'elmcast/elm-vim'
" Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'rhysd/vim-crystal'
Plug 'morhetz/gruvbox'
"Plug 'rust-lang/rust.vim'
"Plug 'cespare/vim-toml'
Plug 'mklabs/split-term.vim'
"Plug 'wlangstroth/vim-racket'
"Plug 'mbbill/undotree'
"Plug 'tpope/vim-fugitive'
"Plug 'critiqjo/lldb.nvim'
Plug 'spolu/dwm.vim'
" Plug 'severin-lemaignan/vim-minimap'
" Plug 'digitaltoad/vim-pug'
" Plug 'cohama/lexima.vim'
Plug 'elixir-lang/vim-elixir'
call plug#end()

" minimap
let g:minimap_highlight='Visual'

"only highlight line in the active pane
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END


" enable truecolor
set termguicolors

colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_light='soft'
let g:gruvbox_contrast_dark='soft'
" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" rust
let g:syntastic_rust_checkers = ['rustc']
" eslint
let g:syntastic_javascript_checkers = ['eslint']
" "elm
let g:elm_syntastic_show_warnings = 1
let g:elm_format_autosave = 1
" enable special fonts for powerline
let g:airline_powerline_fonts = 1
" " pug lint
" let g:syntastic_pug_checkers = ['pug_lint']
"
"horizontal line on cursor
set cursorline

" line nums
set number

 " mouse
set mouse=a

" kill Ex mode
 map Q <Nop>

" jump to the last position when  reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" set doubleclick timeout
set timeoutlen=180

" map out keys to esc
inoremap jj <ESC>

" run make
nnoremap mm :make<CR>

" map double-tap for shifted characters
inoremap ;; :
nnoremap ;; :

" nvim terminal
highlight TermCursor ctermfg=red guifg=red
