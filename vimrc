" vim-plug (https://github.com/junegunn/vim-plug) settings
" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

set ts=4 ic sw=4 expandtab sta ai bs=2 is hls ru vb mouse=a background=dark nu
set encoding=utf-8
set path+=**
set tags+=tags

set ignorecase
set smartcase

set hi=1000          " remember more commands and search history
set undolevels=1000  " use many muchos levels of undo
set wildignore+=*.swp,*.bak,*.pyc,*.class,**/build
set wildmenu

set visualbell
set noerrorbells

set bdir=~/.vim/backup  " backup directory
set dir=~/.vim/swap     " swap dirctory
set udir=~/.vim/undo    " undo directory
set udf  " enable undo file

set mm=20971520    " max memory per buffer
set mmt=268435456  " max memory total

" gui options
set gfn=DejaVu\ Sans\ Mono\ for\ Powerline\ 7
"set go=aegimrLt

set ssop-=options    " do not store global and local values in a session

" Hide uesless stuff in gvim
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

command! Q  quit
command! W  write
command! Wq wq
command! WQ wq
command! C 1,$s///g
command! CQ r ~/.vim/custom_templates/createSqlQuery.txt
command! QL r ~/.vim/custom_templates/sqlQueryLoop.txt
command! CB r ~/.vim/custom_templates/catchBlock.txt
command! Wroot :w !sudo tee %
filetype plugin indent on
syntax on
map <Leader>u :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" Do not show stupid q: window
map q: :q

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

set clipboard=unnamedplus

set formatoptions+=j " Delete comment character when joining commented lines

" Make the dot command work as expected in visual mode https://www.reddit.com/r/vim/comments/3y2mgt/do_you_have_any_minor_customizationsmappings_that/cya0x04
vnoremap . :norm.<CR>

" Allows you to visually select a section and then hit @ to run a macro on all lines https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db#.3dcn9prw6
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Have the indent commands re-highlight the last visual selection to make
" multiple indentations easier
vnoremap > >gv
vnoremap < <gv

" Display relative line numbers
set relativenumber
" display the absolute line number at the line you're on
set number
" Keep the line number gutter narrow so three digits is cozy
set numberwidth=2

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

"themes
Plug 'fatih/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'Pychimp/vim-luna'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
"Plug 'chriskempson/tomorrow-theme'

"file plugins
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
"Plug 'wincent/command-t'
"Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
"Plug 'dhruvasagar/vim-vinegar'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'weynhamz/vim-plugin-minibufexpl'

"plugins
Plug 'majutsushi/tagbar'
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neosnippet-snippets'
Plug 'dgryski/vim-godef'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" ultisnips config
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsListSnippets="s"
let g:UltiSnipsJumpForwardTrigger="n"
let g:UltiSnipsJumpBackwardTrigger="p"
let g:UltiSnipsEditSplit="vertical"

" YouCompleteMe and settings
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1

Plug 'benmills/vimux'
"Plug 'tpope/vim-fugitive'
"Plug 'kien/rainbow_parentheses.vim'
Plug 'MarcWeber/vim-addon-local-vimrc'
Plug 'vimwiki/vimwiki'
Plug 'ervandew/supertab'
Plug 'matze/vim-move'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '│'
set list lcs=tab:\│\ 
Plug 'mhinz/vim-signify'
Plug 'dhruvasagar/vim-table-mode'

"language plugins
"Plug 'scrooloose/syntastic'
Plug 'tfnico/vim-gradle'
Plug 'derekwyatt/vim-scala'
Plug 'fatih/vim-go'
"Plug 'jodosha/vim-godebug'
Plug 'garyburd/go-explorer', { 'do': 'go get -u github.com/garyburd/go-explorer/src/getool' }
Plug 'jplaut/vim-arduino-ino'
" python
Plug 'davidhalter/jedi-vim'
"Plug 'tmhedberg/SimpylFold'
"Plug 'klen/python-mode'
"Plug 'jaredly/vim-debug'
Plug 'udalov/kotlin-vim'

"JavaScript
Plug 'burnettk/vim-angular'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'cakebaker/scss-syntax.vim'

call plug#end()

" colors
set t_Co=256
let g:rehash256 = 1
colorscheme molokai
"let g:molokai_original = 1
let g:solarized_termcolors=256
"colorscheme solarized
let g:gruvbox_contrast_dark="hard"

if &t_Co > 1
   syntax enable
endif


"let g:jedi#popup_on_dot = 0

"syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" vim-go settings (golang)
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 0
let g:go_autodetect_gopath = 1
let g:go_auto_type_info = 1
let g:go_disable_autoinstall = 0

let g:go_highlight_space_tab_error = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"let g:go_snippet_engine = "ultisnips"
let g:godef_split=3

au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gdb <Plug>(go-doc-browser)
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>gc <Plug>(go-coverage)
au FileType go nmap <Leader>d <Plug>(go-def)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>ge <Plug>(go-rename)


"vim move
let g:move_key_modifier = 'C'


"python settings
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>ren"
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = "2"
let g:pymode_run_bind = "<leader>r"
let g:pymode_lint_on_write=0

let g:session_autosave = 'no'

" enable background transparancy
hi Normal ctermbg=NONE

" needed for powerline and airline
set laststatus=2

" tagbar
nmap <leader>t :TagbarToggle<CR>

" Powerline
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme="powerlineish"
let g:airline_section_z="%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#%#__restore__#%#__accent_bold#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__#%#__restore__# :%3vc %3o%{g:airline_symbols.crypt}"

" VimWiki
let g:vimwiki_folding="expr"

" NERDTree
let g:NERDTreeDirArrows = 1
map <C-N> :NERDTreeToggle<CR>
" quit vim if NERDTree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Open NERDTree if VIM started without a filename
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.o$']

"Ctrl P
"nmap <C-P> :CtrlP<CR>
nmap <C-B> :CtrlPBuffer<CR>
nmap <C-F> :CtrlPFunky<CR>

" Arduino
let g:vim_arduino_library_path = "/usr/share/arduino"
let g:vim_arduino_serial_port = "/dev/ttyUSB0"


" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" enable mouse support for wide windows
if !has('nvim')
    set ttymouse=sgr
endif

" an easier to see background color for molokai
"hi Visual ctermbg=237
