call plug#begin('~/.vim/plugged')
" Theme
Plug 'crusoexia/vim-monokai'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
" Tools
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'romainl/vim-qf'
Plug 'romainl/vim-qlist'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-eunuch'
call plug#end()

" Some basics:
    set encoding=utf-8
    set termguicolors
    let g:python3_host_prog = '/usr/bin/python3'
" Indent and line formating
    set tabstop=4
    set shiftwidth=4
    set expandtab
    syntax on
    colorscheme monokai
    set number relativenumber
    set path+=**
    set clipboard=unnamedplus
    set cursorline
    set mouse=a "integer the mouse management
    set noshowmode "as we got the status through airline don't need to display twice
    set autowrite "autosaves before changin buffers
    set autoread "Reload a file when it is changed from the outside
    set lazyredraw "attemps to kill vim lag
    set ttimeoutlen=0 "no timeout when switching modes
    set scrolloff=5

" Search option

    set ignorecase " Ignore case on search
    set smartcase " Ignore case unless there is an uppercase letter in the pattern
    set incsearch " Move cursor to the matched string
    set nohlsearch " Don't highlight matched strings

" Removing trailing white space
    autocmd BufWritePre * %s/\s\+$//e

" Modif command for switch
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>
    set splitbelow
    set splitright

" autoclose
    inoremap " ""<left>
    inoremap ' ''<left>
    inoremap ( ()<left>
    inoremap [ []<left>
    inoremap { {<CR><BS>}<Esc>ko

    set list                              " show whitespace
    set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
    " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
    set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
    if has('linebreak')
        let &showbreak='⤷ '                 " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
    endif
" Set Backup directory
    set backupdir=.nvim/backup/,~/.nvim/backup/,/tmp//
    set directory=.nvim/swp/,~/.nvim/swp/,/tmp//
    set undodir=.nvim/undo/,~/.nvim/undo/,/tmp//

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
