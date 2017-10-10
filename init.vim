" Designed for neovim, also works (okayish) with vim8
" vim:foldmethod=marker:foldlevel=0
" *** Plug *** {{{
call plug#begin('~/.vim/plugged')
"Plug 'fsharp/vim-fsharp'			" fsharp
Plug 'ekalinin/Dockerfile.vim'			" dockerfile
Plug 'elmcast/elm-vim'				" elm
Plug 'davejlong/cf-utils.vim'			" coldfusion / cfmml
Plug 'rhysd/vim-clang-format'			" run clang-format for C / C++
Plug 'sheerun/vim-polyglot'			" language pack
"Plug 'vim-airline/vim-airline'			" airline bar
"Plug 'vim-airline/vim-airline-themes'		" airline themes
Plug 'w0rp/ale'					" linter / fixer
"Plug 'morhetz/gruvbox'				" vim theme
Plug 'kien/rainbow_parentheses.vim'		" rainbow parens for lisp
Plug 'spolu/dwm.vim'				" window manager
Plug 'mklabs/split-term.vim'			" better terminal for nvim, use with :Term
Plug '2072/PHP-Indenting-for-VIm'		" PHP indentation
call plug#end()
" }}}
" *** Language & OS specific config *** {{{
" *** C config *** {{{
" autogenerate ctags
au BufWritePost *.c,*.cpp,*.h,*.hpp silent! !ctags -R &
" }}}
" *** C++ config *** {{{
" run clang-format on save
autocmd FileType c,h,cpp,hpp ClangFormatAutoEnable
" clanc_complete plugin options
" set clang path for MacOS.  Comparison with 'D' instead of 'Darwin' because I
" don't know how to chomp newlines :(
if system('uname')[0] ==? 'D'
	let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
endif
" ClangFormat plugin options
let g:clang_format#code_style = 'llvm'
"let g:clang_format#style_options = {
"	    \ 'UseTab' : 'Never',
"            \ 'Standard' : 'C++11'}
" }}}
" *** JS config *** {{{
" autofix file
autocmd bufwritepost *.js silent !standard --fix %
" }}}
"" *** cscope config *** {{{
"" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
"set cscopetag
"" add any cscope database in current directory
"if filereadable("cscope.out")
"    cs add cscope.out
"" else add the database pointed to by environment variable
"elseif $CSCOPE_DB != ""
"    cs add $CSCOPE_DB
"endif
"" show msg when any other cscope db added
"set cscopeverbose
"" }}}
" *** Lisp config *** {{{
" enable rainbow parens
au VimEnter *.rkt RainbowParenthesesToggle
" }}}
" *** Elm config *** {{{
let g:polyglot_disabled = ['elm']
let g:elm_format_autosave = 1
let g:elm_detailed_complete = 1
au FileType elm setl sw=4 sts=4 et
" }}}

" *** Markdown config *** {{{
" enable markdown higlighting with polyglot
autocmd BufNewFile,BufRead *.md set spell | set lbr | set nonu
let g:markdown_fenced_languages = ['html', 'json', 'css', 'javascript', 'elm', 'vim']
" }}}
" OS detection
if has("win64") || has("win32") || has("win16")
	let g:os = "Windows"
else
	let g:os = system('uname')
endif
" }}}
" *** ALE *** {{{
" ALE general
let g:ale_fix_on_save = 1
" }}}
" *** Editor *** {{{
" rel line nums
set number relativenumber
" rel numbers in normal, absolute numbers in insert
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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
" ignore some file extensions
set wildignore+=*~,*.swp,*.tmp,*.a,*.out,.DS_Store,*.gif,*.bmp,*.png,*.psd,*.bin
" case insensitive searching
set ignorecase
" }}}
" *** Mappings *** {{{
" set doubleclick timeout
set timeoutlen=180
" map out keys to esc
inoremap jj <ESC>
" map double-tap for shifted characters
nnoremap ;; :
" cscope - find all instances of symbol under cursor
nnoremap ]] :cs find s <C-R>=expand("<cword>")<CR><CR>
" map mm to language-specific compile commands
augroup CompileBinds
	autocmd!
	autocmd FileType c,cpp nnoremap mm :make<CR>
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
" change cursorline for insert mode
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
