"-------------  CONFIGURACOES GERAIS  ------------------------------------------
filetype plugin on
filetype indent on
syntax on
set title
set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start
set noerrorbells
set confirm
set hidden
set splitbelow
set splitright
set mouse=a
set number
set relativenumber

" -------------  Configuration file for vim ------------------------------------------
set nomodeline  "CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
" set vi-comaptibility\n

set nocompatible     " Use Vim defaults instead of 100% vi compatibility
set backspace=2      "more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called vy "chpass
au BufWrite /private/etc/pw.* set nowritebackup nobackup

let skip_defaults_vim=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               ██╗    ██╗  ██╗  ███╗   ███╗  
"               ██║    ██║  ██║  ████╗ ████║
"               ██║    ██╝  ██║  ██╔████╝██║     
"               ╚██╗  ██╝   ██║  ██║╚██╝ ██║    
"                 ╚███╝     ██║  ██║ ╚╝  ██║
"                  ╚═╝      ╚═╝  ╚═╝     ╚═╝
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""" CONFIGURACAO DO VIM COMO IDE PARA HASSEGA BY BLAU """"""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''"
"-------------  DEFINACAO DAS CORES DO TERMINAL --------------------------------
if has('termguicolors')
    set termguicolors
else
    set t_Co=256
endif

"-------------  CAMINHOS  ------------------------------------------------------
set path=.,**
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

"-------------  VARIAVEIS  -----------------------------------------------------
"let $RCPATH = '~/.vim/'
"let $RC = $RCPATH. 'vimrc'

"-------------  QUEBRA DE LINHAS  ----------------------------------------------
set nowrap
set linebreak

"-------------  ALTERNAR QUEBRA DE LINHA  --------------------------------------
map <F3> :set wrap!<cr>

"-------------  ABRIR TERMINAL  ------------------------------------------------  
map <F4> :term<cr>  "control D fecha terminal

"------------- ABRIR TERMINAL PARA EXECUTAR A SCRIPT EM EDICAO  ----------------
map <F5> :term ./%<cr>

"------------- ALTERNAR CARACTERES INVISIVEIS ----------------------------------
map <F6> :set list<cr>

"------------- EXIB ESTATISTICAS DO ARQUIVO ----------------------------------
map  <F7> g<c-g>
imap <F7> <c-o>g<c-g>

"------------- ABRE DEBUGER NO TERMINAL ----------------------------------------
map <F8> :term gdb<cr>

"------------- EXECUTAR MAKE (REQUER MAKEFILE NO DIRETORIO ---------------------
map <F9> :term make<cr>

"------------- MAPEAMENTO DA TECLA DE ATALHO -----------------------------------
let mapleader = ' '

"------------- ATALHO PARA EXECUTAR RUN NO PYTHON (:!python3 %) ----------------
nnoremap <C-r> :!python3 % <cr>

"------------- ABRIR TERMINAL LADO DIREITO E ESQUERDO --------------------------
nnoremap <C-b> :vsp<cr>
nnoremap <C-d> :belowright<cr>

"------------- SALVAR COM CTRL + S ---------------------------------------------
nnoremap <C-s> :w!<cr>

"------------- SAIR COM CRTL + q -----------------------------------------------
nnoremap <C-q> :q<cr>

"------------- RECORTAR PARA AREA DE TRANSFERENCIA -----------------------------
nnoremap <C-x> :+y<cr>

"------------- COLAR DA AREA DE TRANSFERENCIA ----------------------------------
nnoremap <C-v> :+p<cr>

"------------- COPIAR ----------------------------------------------------------
nnoremap <C-c> :y<cr>

"------------- DESTAQUE DE BUSCA -----------------------------------------------
map <silent> <leader>hh :set hls!<cr>
map <silent> <leader>hc :set @/ = ""<cr>

"------------- COPIAR E RECORTAR SELECAO PARA AREA DE TRANSFERENCIA ------------
vmap <silent> <leader>yy "+y
vmap <silent> <leader>dd "+c

"------------- SALVAR SOMENTE SE HOUVER MUDANCAS -------------------------------
map <leader>w :update<cr>

"------------- COLAR ULTIMA COPIA EM VEZ DE ULTIMO RECORTE --------------------- 
map <leader>p "0p
map <leader>P "0P

"------------- NOVO BUFFER VAZIO -----------------------------------------------
map <leader>bn :enew<cr>

"------------- NAVEGAR ENTRE BUFFERS F1 e F2 -----------------------------------
nnoremap <F1> :bp<cr>
nnoremap <F2> :bn<cr>

"------------- DESTAQUE DE COLUNA ----------------------------------------------
map <silent> <leader>cc :execute "set cc=" . (&colorcolumn == "" ? "80" : "")<cr>

"-------------  CARACTERES DE PREENCHIMENTO  -----------------------------------
set nolist
set listchars=tab:›-,space:·,trail:◀,eol:↲   " caracteres nao imprimiveis """""
set fillchars=vert:│,fold:-,eob:~,lastline:@

"-------------  NUMERACOES LINHAS E CURSOR  ------------------------------------
set number 
set relativenumber
set scrolloff=2
set cursorline

"-------------  MUDAR BLOCO PARA BARRA NO MODOS INS E VISUAL  -----------------
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"

"-------------  INDENTACAO  ---------------------------------------------------
set autoindent
set smartindent

"-------------  TABULACAO  ----------------------------------------------------
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"-------------  BUSCA COM CAIXA TEXTO DIFER. MAISC E MIN  ----------------------
set ignorecase
set smartcase
set incsearch
set hls
let @/ = ""

"-------------  ORTOGRAFIA  ----------------------------------------------------
set nospell
set spelllang=pt_br,en
"set complete+=kspell
"set completeopt=menuone,longest
"set shortmess+=c
" Insert completion...

"------------- MAPEAMENTO BASICO AUTOCOMPLETE ----------------------------------
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap " ""<left>
inoremap ' ''<left>

"-------------  ALTERNAR CORRECAO ORTOGRAFICA  ---------------------------------
map <F3> :set spell!<cr>

"------------- SELECAO COM SETAS UP E DOWN -------------------------------------
inoremap <expr> <up> pumvisible() ? '<c-p>' : '<up>'
inoremap <expr> <down> pumvisible() ? '<c-n>' : '<down>'

"------------- ACEITAR COM SETA DIREITA OU ENTER  -----------------------------
inoremap <expr> <right> pumvisible() ? '<c-y>' : '<right>'
inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'

"--------------  CANCELAR COMPLETION COM SETA ESQUERDA  ------------------------
inoremap <expr> <left> pumvisible() ? '<c-e>' : '<left>'

"---------------  HASHBANGS  ----------------------------------------------------
function! Hashbangs()
    let hb = ['#!/bin/bash', '#!/usr/bin/env bash', '#!/bin/sh', '#!/usr/bin/awk -f']
    call complete(col('.'), hb)
    return ''
endfunction     

"imap <c-x>c <c-r>=Hashbangs()<cr>
imap <c-F12> <c-r>=Hashbangs()<cr>

"------------- MENU SELVAGEM ---------------------------------------------------
set wildmenu
set wildmode=longest,full
set wildoptions=pum

"------------- COLOR THEMES ----------------------------------------------------
" https://github.com/sainnhe/edge.git 
" set background=dark
" colorscheme edge

"------------------------------------------------------------------------------
colorscheme darkblue 

"-------------  BARRA DE STATUS  -----------------------------------------------
set noshowmode
set laststatus=2

hi statusline   cterm=NONE ctermfg=0 ctermbg=7   guibg=#C1C2D0 guifg=#000000
hi statuslinenc cterm=NONE ctermfg=0 ctermbg=240 guibg=#616270 guifg=#000000

augroup ModeEvents
    autocmd!
    au InsertEnter * hi statusline cterm=NONE ctermfg=0 ctermbg=10 guibg=#7BC86F
    au InsertLeave * hi statusline cterm=NONE ctermfg=0 ctermbg=7 guibg=#C1C2D0
    au ModeChanged *:[vV\x16]* hi statusline cterm=NONE ctermfg=0 ctermbg=13 guibg=#C990DC
    au Modechanged [vV\x16]*:* hi statusline cterm=NONE ctermfg=0 ctermbg=7 guibg=#C1C2D0
augroup end

function! LoadStatusLine()

    let g:left_sep='\'
    let g:right_sep='/'

    let g:currentmode={
        \ 'n'  : 'Normal',
        \ 'no' : 'Normal-Operator Pending',
        \ 'v'  : 'Visual',
        \ 'V'  : 'V-Line',
        \ '' : 'V-Block',
        \ 's'  : 'Select',
        \ 'S'  : 'S-Line',
        \ '' : 'S-Block',
        \ 'i'  : 'Insert',
        \ 'R'  : 'Replace',
        \ 'Rv' : 'V-Replace',
        \ 'c'  : 'Command',
        \ 'cv' : 'Vim Ex',
        \ 'ce' : 'Ex',
        \ 'r'  : 'Prompt',
        \ 'rm' : 'More',
        \ 'r?' : 'Confirm',
        \ '!'  : 'Shell',
        \ 't'  : 'Terminal'
        \}

    set statusline=\ %{toupper(g:currentmode[mode()])}
    set statusline=\ %{toupper(mode())}
    set statusline+=\ %{left_sep}
    set statusline+=\ %n
    set statusline+=\ %{left_sep}
    set statusline+=\ %f%m\ %y
    set statusline+=\ %{left_sep}
    set statusline+=\ %{&ff}\ %{&fenc!=''?&fenc:&enc}
    set statusline+=\ %{left_sep}
    set statusline+=\ %=
    set statusline+=\ %{right_sep}
    set statusline+=\ %l/%L,%v
    set statusline+=\ %{right_sep}
    set statusline+=\ %P\ 

endfunction

call LoadStatusLine()

"-------------  ESQUEMA DE CORES  ----------------------------------------------
"-------------  FUNDO TRANSPARENTE  --------------------------------------------
hi Normal guibg=NONE ctermbg=NONE

"-------------  LINHA DO CURSOR  -----------------------------------------------
hi CursorLine guibg=#202130

"-------------  COMENTARIOS EM ITALICO  ----------------------------------------
hi Comment cterm=italic gui=italic

"-------------  DIVISAO VERTICAL DE JANELAS  -----------------------------------
hi VertSplit ctermbg=NONE guibg=NONE ctermfg=7 guifg=#c1c2d0

"-------------  BARRA DE ABAS  -------------------------------------------------
hi TabLine      guifg=#9192a0 guibg=#303140 gui=none
hi TabLineSel   guifg=#a1a2b0 guibg=#101120 gui=bold
hi TabLineFill  guifg=#9192a0 guibg=#303140 gui=none

"-------------  SELECAO MODO VISIAL  -------------------------------------------
hi Visual guifg=NONE guibg=#303140

"------------- HABILITAR O METODO DE MARCACAO PARA DOBRAMENTO CODIGO -----------
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim set foldlevelstart=30
    autocmd FileType vim setlocal foldmarker={{{,}}}
augroup END

"------------- ARQUIVOS EXTERNOS  ----------------------------------------------
"execute 'source '.$RCPATH.fnameescape('autocmds.vim')
"execute 'source '.$RCPATH.fnameescape('customcolors.vim')
"execute 'source '.$RCPATH.fnameescape('statusbar.vim')
"execute 'source '.$RCPATH.fnameescape('mappings.vim')

"------------------------------------------------------------------------------
"execute 'source '.$RCPATH.fnameescape('icomplete.vim')

" Azhrael editou
" Azhrael editou
