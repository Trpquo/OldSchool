
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
" "       (Amir Salihefendic - @amix3k)
" "       Trpimir - @trpquo
" " " " Awesome_version:
" "       Get this config, nice color schemes and lots of plugins!
" "
" "       Install the awesome version from:
" "
" "           https://github.com/amix/vimrc
" "
" " Sections:
" "    -> General
" "    -> VIM user interface
" "    -> Colors and Fonts
" "    -> Files and backups
" "    -> Text, tab and indent related
" "    -> Visual mode related
" "    -> Moving around, tabs and buffers
" "    -> Status line
" "    -> Editing mappings
" "    -> vimgrep searching and cope displaying
" "    -> Spell checking
" "    -> Misc
" "    -> Helper functions
" "
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => General
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Set new .viminfo location
set viminfo+=n~/.config/vim/.viminfo
"
" " Sets how many lines of history VIM has to remember
set history=500
"
" " Enable filetype plugins
filetype plugin on
filetype indent on
"
" " Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * silent! checktime
"
" " With a map leader it's possible to do extra key combinations
" " like <leader>w saves the current file
let mapleader = " "
"
" " Fast moving 
nnoremap <leader>j J
nnoremap J 3j
vnoremap J 3j
nnoremap K 3k
vnoremap K 3k
nnoremap H 0 " jump to the beginning
nnoremap L $
inoremap kj <Esc>
nnoremap <leader>h :noh<cr>

" " Managing documents
" " Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <C-s> :w!<cr>
inoremap <C-s> :w!<cr>
vnoremap <C-s> :w!<cr>
" " Fast closing
nnoremap <C-q> :q<cr>
inoremap <C-q> :q<cr>
vnoremap <C-q> :q<cr>

" " Managing panes
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
"
" " Managing tabs
nnoremap <leader>tt :tabnew<cr>
nnoremap <leader>tn :tabn<cr>
nnoremap <leader>tp :tabp<cr>

" " :W sudo saves the file
" " (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
"
"
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => VIM user interface
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a
" " Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
" source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/menu.vim
"
" " Turn on the Wild menu
set wildmenu
"
" " Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
    else
        set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
        endif
" " Show numberlines
set number relativenumber numberwidth=6

"  Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch matchtime=1

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
      autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=0
"
"
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text editor config
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Manage typograpgical tabs
set autoindent
set expandtab
set shiftround
set shiftwidth=2
set smarttab
set tabstop=2

" " Manage rows
set linebreak " awoid wrapping a line in the middle of the word
set scrolloff=7 " number of screenlines above and below the cursor
set sidescrolloff=7 " number of columns to keep to the left and right of cursor

" " Fast editing
nnoremap <BS> dd " delete whole line with backspace
nnoremap <space> viw " select a word with the spacebar
 
" Brutala (za odvikavanje od strjelica)
nnoremap <down> ddp
nnoremap <up> ddkP
" vnoremap <up> dkP
" vnoremap <down> dp

" shift+arrow selection (not working)
set keymodel=startsel,stopsel

" " Fast editing of .vimrc
nnoremap <leader>rc :vsplit $VIMRC<cr>
nnoremap <leader>sc :source $VIMRC<cr>

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Enable syntax highlighting
syntax enable

" " Set regular expression engine automatically
set regexpengine=0

" " Enable 256 colors palette in Gnome Terminal
" if $COLORTERM == 'gnome-terminal'
"     set t_Co=256
" endif
" " Set extra options when running in GUI mode
" if has("gui_running")
"      set guioptions-=T
"      set guioptions-=e
"      set t_Co=256
"      set guitablabel=%M\ %t
" endif


colorscheme shine
set background=light
set cursorline

highlight Cursor cterm=bold gui=bold
highlight CursorLine cterm=inverse gui=inverse
highlight CursorLineNr NONE ctermbg=6 ctermfg=7
highlight Search NONE ctermfg=5 ctermbg=7 
highlight Visual NONE ctermfg=7 ctermbg=6 
highlight LineNr NONE ctermfg=9

" Always show current position
set ruler

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
"
" Use Unix as the standard file type
set ffs=unix,dos,mac


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

