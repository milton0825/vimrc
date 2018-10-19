" milton0825
" Reference: https://dougblack.io/words/a-good-vimrc.html

" vundle {{{
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" https://github.com/Valloric/YouCompleteMe
" Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
" https://vimawesome.com/plugin/fugitive-vim
Plugin 'tpope/vim-fugitive'

" https://vimawesome.com/plugin/ctrlp-vim-red
Plugin 'kien/ctrlp.vim'

" https://vimawesome.com/plugin/ag-vim
Plugin 'rking/ag.vim'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on
" }}}
" color {{{

" set color scheme
"
" git clone https://github.com/sjl/badwolf.git
" move color directory to .vim/
colorscheme badwolf

" enable syntax processing 
syntax enable

" }}}
" tab and space {{{

" number of visual spaces per TAB
set tabstop=4

" number of spaces in tab when editing
"
" tabstop is the number of spaces a tab counts for. 
" So, when Vim opens a file and reads a <TAB> character, 
" it uses that many spaces to visually show the <TAB>.
set softtabstop=4

" number of spaces in tab when editing
"
" this value is the number of spaces that is inserted when you 
" hit <TAB> and also the number of spaces that are removed when you backspace.
set softtabstop=4

" tabs are spaces
"
" expandtab turns <TAB>s into spaces. 
" So <TAB> just becomes a shortcut for insert four spaces.
set expandtab 

" }}}
" UI config {{{

" show line numbers
set number

" show command in bottom bar
set showcmd

" highlight current line
set cursorline

" load filetype-specific indent files
"
" This both turns on filetype detection and allows loading of language 
" specific indentation files based on that detection. 
" For me, this means the python indentation file that 
" lives at ~/.vim/indent/python.vim gets loaded every time I open a *.py file.
filetype indent on

" visual autocomplete for command menu
set wildmenu 

" redraw only when we need to.
set lazyredraw

" highlight matching [{()}]
set showmatch 

" }}}
" search {{{

" search as characters are entered
set incsearch

" highlight matches
set hlsearch

" }}}
" folding {{{

" enable folding
set foldenable

" open most folds by default
"
" foldlevelstart is the starting fold level for opening a new buffer. 
" If it is set to 0, all folds will be closed. 
" Setting it to 99 would guarantee folds are always open. 
" So, setting it to 10 here ensures that only very nested blocks of code 
" are folded when opening a buffer.
set foldlevelstart=10

" 10 nested fold max
" 
" Folds can be nested. Setting a max on the number of folds guards against too many folds.  
set foldnestmax=10 

" space open/closes folds
nnoremap <space> za

" }}}
" ag {{{

" use :Ag to search files 
" 
" To install ag: 
" $ brew install the_silver_searcher
" Then add ag as vim plugin:
" visit https://github.com/rking/ag.vim
set runtimepath^=~/.vim/bundle/ag

 " }}}
" autogroups {{{

" This is a slew of commands that create language-specific settings
" for certain filetypes/file extensions. It is important to note 
" they are wrapped in an augroup as this ensures the autocmd's are 
" only applied once. 
" In addition, the autocmd! directive clears all the autocmd's for the current group.
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}
" custom functions {{{
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" }}}
" keys {{{
set backspace=indent,eol,start
" }}}
" organization {{{

set foldmethod=marker

" close every fold by default 
set foldlevel=0

" We can use a modeline to make Vim only use these settings for this file. 
" Modelines are special comments somewhere in a file that can can declare 
" certain Vim settings to be used only for that file. 
" So we'll tell Vim to check just the final line of the file for a modeline.
set modelines=1

" }}} 

" vim:foldmethod=marker:foldlevel=0
