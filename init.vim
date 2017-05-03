" vim:foldmethod=marker:foldlevel=0
" *** Plug *** {{{
call plug#begin('~/.vim/plugged')
" Plug 'fsharp/vim-fsharp', {
"       \ 'for': 'fsharp',
"       \ 'do':  'make fsautocomplete',
"       \}
" Plug 'elmcast/elm-vim'
" Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
Plug 'chazy/cscope_maps'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'rhysd/vim-crystal'
Plug 'morhetz/gruvbox'
" Plug 'rust-lang/rust.vim'
" Plug 'cespare/vim-toml'
Plug 'wlangstroth/vim-racket'
Plug 'kien/rainbow_parentheses.vim'
" Plug 'mbbill/undotree'
" Plug 'tpope/vim-fugitive'
" Plug 'critiqjo/lldb.nvim'
Plug 'spolu/dwm.vim'
Plug 'mklabs/split-term.vim'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'severin-lemaignan/vim-minimap'
" Plug 'digitaltoad/vim-pug'
" Plug 'cohama/lexima.vim'
Plug 'elixir-lang/vim-elixir'
" Plug 'Valloric/YouCompleteMe', { 'do': 'python ./install.py' }
call plug#end()
" }}}
" *** Language & OS specific config *** {{{
" *** C config *** {{{
" autogenerate ctags
au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &
" }}}
" *** Lisp config *** {{{
" enable rainbow parens
au VimEnter *.rkt RainbowParenthesesToggle
" }}}
" OS detection
if has("win64") || has("win32") || has("win16")
	let g:os = "Windows"
else
	let g:os = system('uname')
endif
" }}}
" *** Syntastic *** {{{
" syntastic general
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" rust
let g:syntastic_rust_checkers = ['rustc']
" eslint
let g:syntastic_javascript_checkers = ['eslint']
" elm
let g:elm_syntastic_show_warnings = 1
let g:elm_format_autosave = 1
" racket - WARNING: ALLOWS ARBITRARY CODE EXECUTION!
let g:syntastic_enable_racket_racket_checker = 1
" " pug lint
" let g:syntastic_pug_checkers = ['pug_lint']
"
" gets evaluated last
" }}}
" *** Editor *** {{{
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
" }}}
" *** Search *** {{{
" unhighlight search
nnoremap // :nohlsearch<CR>
" search as I type
set incsearch
" }}}
" *** Mappings *** {{{
" set doubleclick timeout
set timeoutlen=180
" map out keys to esc
inoremap jj <ESC>
" map double-tap for shifted characters
inoremap ;; :
nnoremap ;; :
" map mm to language-specific compile commands
augroup CompileBinds
        autocmd!
        autocmd FileType c nnoremap mm :make<CR>
        autocmd FileType elixir nnoremap mm :!mix compile<CR>
augroup End
" }}}
" *** Cosmetics *** {{{
" *** Colorscheme *** {{{
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_light='soft'
let g:gruvbox_contrast_dark='soft'
" }}}"only highlight line in the active pane
" horizontal line on cursor
set cursorline
augroup BgHighlight
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinLeave * set nocul
augroup END
augroup CulHighlight
	autocmd!
	autocmd InsertEnter * hi cursorline guibg=Black
	autocmd InsertLeave * hi cursorline guibg=#3c3836
augroup END
" enable special fonts for powerline
let g:airline_powerline_fonts = 1
" set airline theme
let g:airline_theme='base16'
" enable truecolor- some compatibility issues?
set termguicolors
" red cursor when terminal is active - this line needs to be exaluated after
highlight TermCursor ctermfg=red guifg=red
" }}}
