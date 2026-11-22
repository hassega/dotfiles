"================================================================================================
"=============  ARQUIVO DE CONFIGURAÇÃO DO VIM  =============================================={{{
" configuration file for vim
set nomodeline  "CVE-2007-2438
set nocompatible
set backspace=indent,eol,start
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
au BufWrite /private/etc/pw.* set nowritebackup nobackup
let skip_defaults_vim=1
"}}}
"================================================================================================
"               ██╗    ██╗  ██╗  ███╗   ███╗
"               ██║    ██║  ██║  ████╗ ████║
"               ██║    ██╝  ██║  ██╔████╝██║
"               ╚██╗  ██╝   ██║  ██║╚██╝ ██║
"                 ╚███╝     ██║  ██║ ╚╝  ██║
"                  ╚═╝      ╚═╝  ╚═╝     ╚═╝
"================================================================================================
" CONFIGURACAO DO VIM COMO IDE PARA SCRIPT, PYTHON & RUST HASSEGA BY BLAU "
"============================================================================================={{{
" }}}
"================================================================================================
"=============  CONFIGURACOES GERAIS  ========================================================{{{
filetype plugin on
filetype plugin indent on
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
"}}}
"================================================================================================
" 1. GERENCIADOR DE PLUGINS (Vim-Plug)
"================================================================================================
"============================================================================================={{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"==== Temas =================================================================================={{{
Plug 'ghifarit53/tokyonight-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
" }}}
"==== Explorador de Arquivos e Ícones ========================================================{{{
Plug 'preservim/nerdtree'
Plug 'sickill/vim-monokai'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'agude/vim-eldar'
Plug 'ryanoasis/vim-devicons'
" }}}
"==== Suporte Avançado e Sintaxe Dinâmica para Python ========================================{{{
Plug 'vim-python/python-syntax'
Plug 'dense-analysis/ale'
Plug 'Yggdroot/indentLine'
" }}}
"===== Programacao Rust ======================================================================{{{
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }}}
call plug#end()
"}}}
"================================================================================================
" 2. CONFIGURAÇÕES DE CORES E TEMA
"================================================================================================
"============================================================================================={{{
if has('termguicolors')
 set termguicolors
else
 set t_Co=256
endif
"============ Ativar demais temas " =========================================================={{{
" colorscheme dracula
" colorscheme monokai
colorscheme eldar
" colorscheme default
" colorscheme onedark
" colorscheme darkblue
" colorscheme tokyonight
" }}}
"============ Configuração do indentLine ====================================================={{{
let g:indentLine_enabled = 1
let g:indentLine_char = '│'
let g:indentLine_color_term = 4
let g:indentLine_color_gui = '#0000FF'
let g:indentLine_setConceal = 0
"}}}
"}}}
"================================================================================================
"=======  CAMINHOS  =========================================================================={{{
set path=.,**
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
"}}}
"================================================================================================
"============  QUEBRA DE LINHAS  ============================================================={{{
set nowrap
set linebreak
"}}}
"================================================================================================
"============  ALTERNAR QUEBRA DE LINHA ======================================================{{{
map <F3> :set wrap!<cr>
"}}}
"================================================================================================
"============  ABRIR TERMINAL  ==============================================================={{{
map <F4> :term<cr>
"}}}
"================================================================================================
"============ ALTERNAR CARACTERES INVISIVEIS ================================================={{{
map <F6> :set list!<cr>
"}}}
"================================================================================================
"============ EXIBE ESTATISTICAS DO ARQUIVO =================================================={{{
map  <F7> g<C-g>
imap <F7> <c-o>g<C-g>
"}}}
"================================================================================================
"============ ABRE DEBUGER NO TERMINAL ======================================================={{{
map <F8> :term gdb<cr>
"}}}
"================================================================================================
"==============  EXECUTAR MAKE ==============================================================={{{
map <F9> :term make<cr>
"}}}
"================================================================================================
"============= MAPEAMENTO DA TECLA DE ATALHO ================================================={{{
let mapleader = ' '
"}}}
"================================================================================================
"=========== ABRIR TERMINAL LADO DIREITO E ESQUERDO =========================================={{{
nnoremap <C-b> :vsp<cr>
nnoremap <C-d> :belowright<cr>
"}}}
"================================================================================================
"======== Atalho para abrir/fechar o NERDTree com Control + N ================================{{{
nnoremap <C-n> :NERDTreeToggle<CR>
"}}}
"================================================================================================
"======== SALVAR COM CTRL + S ================================================================{{{
nnoremap <C-s> :w!<cr>
"}}}
"================================================================================================
"=========== SAIR COM CRTL + q ==============================================================={{{
nnoremap <C-q> :q<cr>
"}}}
"================================================================================================
"=========== COPIAR RECORTAR COLAR PARA AREA DE TRANSFERENCIA ================================{{{
nnoremap <C-x> "+y
nnoremap <C-v> "+p
nnoremap <C-c> "+y
vmap <silent> <leader>yy "+y
vmap <silent> <leader>dd "+c
map <leader>w :update<cr>
map <leader>p "0p
map <leader>P "0P
"}}}
"================================================================================================
"============ TRABALHAR E NAVEGAR ENTRE BUFFERS F1 e F2 ======================================{{{
nnoremap <F1> :bp<cr>
nnoremap <F2> :bn<cr>
map <leader>bn :enew<cr>
"}}}
"================================================================================================
"=================== DESTAQUE DE COLUNA ======================================================{{{
map <silent> <leader>cc :execute "set cc=" . (&colorcolumn == "" ? "80" : "")<cr>
"}}}
"================================================================================================
"============ LINHAS DE INDENTAÇÃO NATIVAS ==================================================={{{
set list
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set listchars=tab:›-,space:·,trail:◀,eol:↲,leadmultispace:│\ \ \
set fillchars=vert:│,fold:-,eob:~,lastline:@
highlight SpecialKey ctermfg=blue guifg=blue
highlight NonText ctermfg=blue guifg=blue
set scrolloff=2
set cursorline
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"
"}}}
"================================================================================================
"=============  AUTOMACOES PARA SHELL SCRIPT  ================================================{{{
function! IniciarScriptShell()
    call setline(1, '#!/bin/bash')
    call append(1, '')
    call cursor(2, 1)
    startinsert
endfunction

augroup ShellScripting
    autocmd!
    autocmd BufNewFile *.sh call IniciarScriptShell()
    autocmd BufWritePost *.sh silent! !chmod +x %
    autocmd BufWritePost *.sh silent! make | redraw!
augroup END
"}}}
"================================================================================================
"==========  BUSCA ============================================================================{{{
set ignorecase
set smartcase
set incsearch
set hls
let @/ = ""
map <silent> <leader>hh :set hls!<cr>
map <silent> <leader>hc :let @/ = ""<cr>
"}}}
"================================================================================================
"==============  CORRECAO  ORTOGRAFICA ======================================================={{{
set nospell
set spelllang=pt_br,en
map <F5> :set spell!<cr>
"}}}
"================================================================================================
"============ MAPEAMENTO BASICO AUTOCOMPLETE ================================================={{{
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
"}}}
"================================================================================================
"=====================  TRABALHO COM SETAS ==================================================={{{
inoremap <expr> <up> pumvisible() ? '<c-p>' : '<up>'
inoremap <expr> <down> pumvisible() ? '<c-n>' : '<down>'
inoremap <expr> <right> pumvisible() ? '<c-y>' : '<right>'
inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'
inoremap <expr> <left> pumvisible() ? '<c-e>' : '<left>'
function! Hashbangs()
    let hb = ['#!/bin/bash', '#!/usr/bin/env bash', '#!/bin/sh', '#!/usr/bin/awk -f']
    call complete(col('.'), hb)
    return ''
endfunction
imap <c-F12> <c-r>=Hashbangs()<cr>
"}}}
"================================================================================================
"============= MENU SELVAGEM  ================================================================{{{
set wildmenu
set wildmode=longest,full
set wildoptions=pum
"}}}
"================================================================================================
"================ BARRA DE STATUS ============================================================{{{
set noshowmode
set laststatus=2
hi statusline cterm=NONE ctermfg=0 ctermbg=7 guibg=#C1C2D0 guifg=#000000
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
    \ "\<C-v>" : 'V-Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S-Line',
    \ "\<C-s>" : 'S-Block',
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
    set statusline+=\ %{toupper(mode())}
    set statusline+=\ \\
    set statusline+=\ %n
    set statusline+=\ \\
    set statusline+=\ %f%m\ %y
    set statusline+=\ \\
    set statusline+=\ %ff\ %{&fenc!=''?&fenc:&enc}
    set statusline+=\ \\
    set statusline+=\ %=
    set statusline+=\ /
    set statusline+=\ %l/%L,%v
    set statusline+=\ /
    set statusline+=\ %P\ 
endfunction
call LoadStatusLine()
"}}}
"================================================================================================
"============== ESQUEMA DE CORES ============================================================={{{
hi Normal guibg=NONE ctermbg=NONE
hi CursorLine guibg=#2e2a24
hi Comment cterm=italic gui=italic
"}}}
"================================================================================================
"============= DIVISAO VERTICAL DE JANELAS ==================================================={{{
hi VertSplit ctermbg=NONE guibg=NONE ctermfg=7 guifg=#c1c2d0
"}}}
"================================================================================================
"============= BARRA DE ABAS ================================================================={{{
hi TabLine guifg=#9192a0 guibg=#303140 gui=none
hi TabLineSel guifg=#a1a2b0 guibg=#101120 gui=bold
hi TabLineFill guifg=#9192a0 guibg=#303140 gui=none
"}}}
"================================================================================================
"============= SELECAO MODO VISUAL  =========================================================={{{
hi Visual guifg=NONE guibg=#303140
"}}}
"================================================================================================
"=============   HABILITAR O METODO DE MARCACAO PARA DOBRAMENTO CODIGO  ======================{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevelstart=30
    autocmd FileType vim setlocal foldmarker={{{,}}}
augroup END
"}}}
"================================================================================================
" BACKUP AUTOMÁTICO
"============================================================================================={{{
augroup AutoVimBackup
    autocmd!
    autocmd BufWritePre *vimrc silent! !mkdir -p ~/vim_backups
    autocmd BufWritePre *vimrc execute "!cp % ~/vim_backups/" . substitute(expand('%:t'), '^\.', '', '') . "_auto_" . strftime('%Y-%m-%d_%Hh%M')
augroup END
"}}}
"================================================================================================
" RUST: PROGRAMAR E COMPILAR
"============================================================================================={{{
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:cargo_makeprg_params = 'check'
let g:coc_rust_analyzer_server_path = $HOME . '/.cargo/bin/rust-analyzer'

augroup RustAutoCmds
    autocmd!
    autocmd FileType rust compiler cargo
    autocmd FileType rust setlocal colorcolumn=100
    autocmd InsertLeave *.rs cwindow
augroup END

autocmd FileType rust nnoremap <buffer> <F5> :RustRun<CR>
autocmd FileType rust nnoremap <buffer> <leader>cb :Cargo build<CR>
autocmd FileType rust nnoremap <buffer> <leader>cc :Cargo check<CR>
autocmd FileType rust nnoremap <buffer> <leader>cf :RustFmt<CR>
autocmd FileType rust nnoremap <buffer> <leader>ct :RustTest<CR>
autocmd FileType rust nnoremap <buffer> <leader>cr :RustRun 

autocmd FileType rust nmap <buffer> gd <Plug>(coc-definition)
autocmd FileType rust nmap <buffer> gr <Plug>(coc-references)
autocmd FileType rust nmap <buffer> K :call CocActionAsync('doHover')<CR>
autocmd FileType rust nmap <buffer> <leader>rn <Plug>(coc-rename)
autocmd FileType rust nmap <buffer> <leader>a <Plug>(coc-codeaction)
autocmd FileType rust nmap <buffer> <leader>f <Plug>(coc-format)
autocmd FileType rust nnoremap <buffer> <leader>e :CocDiagnostics<CR> 
"}}}
"================================================================================================
" PYTHON: PROGRAMAR, AUTOMAÇÃO E COMPILAÇÃO
"============================================================================================={{{
let g:ale_linters = { 'python': ['flake8'] }
let g:ale_python_flake8_executable = '~/.local/bin/flake8'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠'

autocmd FileType python nnoremap <silent> <buffer> <C-j> :ALENextWrap<CR>
autocmd FileType python nnoremap <silent> <buffer> <C-k> :ALEPreviousWrap<CR>

augroup PythonAutoCmds
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab textwidth=79 colorcolumn=80 nosmartindent
augroup END

autocmd FileType python command! -buffer -nargs=0 F silent !~/.local/share/pipx/venvs/black/bin/black -q % | edit!
autocmd FileType python command! -buffer -nargs=0 Format silent !~/.local/share/pipx/venvs/black/bin/black -q % | edit!

autocmd FileType python nnoremap <buffer> <C-r> :F<CR>:w<CR>:!python3 %<CR>
autocmd FileType python nnoremap <buffer> <leader>py :w<CR>:!python3 %<CR>
autocmd FileType python nmap <buffer> gd <Plug>(coc-definition)
autocmd FileType python nmap <buffer> gr <Plug>(coc-references)

function! IniciarScriptPython()
    call setline(1, '#!/usr/bin/env python3')
    call append(1, '# -*- coding: utf-8 -*-')
    call append(2, '')
    call append(3, 'def main():')
    call append(4, '    print("Olá, Python!")')
    call append(5, '')
    call append(6, 'if __name__ == "__main__":')
    call append(7, '    main()')
    call cursor(5, 5)
    startinsert
endfunction

augroup PythonAutomations
    autocmd!
    autocmd BufNewFile *.py call IniciarScriptPython()
    autocmd BufWritePost *.py silent! !chmod +x %
augroup END
"}}}
"================================================================================================
" CONFIGURAÇÃO GERAL COMPARTILHADA DO COC.NVIM
"============================================================================================={{{
set updatetime=300
set signcolumn=yes
autocmd CursorHold * silent call CocActionAsync('highlight')
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"}}}
"================================================================================================
" OLLAMA VIA CURL - FUNCIONA NO VIM PURO
"============================================================================================={{{
function! OllamaFix() range
    let l:code = join(getline(a:firstline, a:lastline), "\n")
    let l:prompt = "Analisa e corrige esse código. Retorna só o código corrigido com # CORREÇÃO: nos locais alterados e depois liste as linhas corrigidas:\n\n" . l:code
    let l:json = json_encode({'model': 'br', 'prompt': l:prompt, 'stream': v:false})
    let l:cmd = "curl -s http://localhost:11434/api/generate -d " . shellescape(l:json)
    echo "Corrigindo com br..."
    let l:response = system(l:cmd)
    let l:output = json_decode(l:response)['response']
    execute a:firstline . "," . a:lastline . "delete"
    call append(a:firstline-1, split(l:output, "\n"))
endfunction

function! OllamaAsk()
    let l:prompt = input('Pergunta pro br: ')
    if l:prompt == '' | return | endif
    let l:json = json_encode({'model': 'br', 'prompt': l:prompt, 'stream': v:false})
    let l:cmd = "curl -s http://localhost:11434/api/generate -d " . shellescape(l:json)
    echo "Pensando..."
    let l:response = system(l:cmd)
    let l:output = json_decode(l:response)['response']
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile
    call append(0, split(l:output, "\n"))
endfunction

command! -range OllamaFix <line1>,<line2>call OllamaFix()
command! OllamaAsk call OllamaAsk()
command! OllamaFixAll 1,$call OllamaFix()
nnoremap <leader>cv :OllamaFixAll<CR>
"}}}
