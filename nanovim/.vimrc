" configuration file for vim
set nomodeline  "CVE-2007-2438
set nocompatible     " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start      "more powerful backspacing
" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called vy "chpass
au BufWrite /private/etc/pw.* set nowritebackup nobackup
let skip_defaults_vim=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               ██╗    ██╗  ██╗  ███╗   ███╗  
"               ██║    ██║  ██║  ████╗ ████║
"               ██║    ██╝  ██║  ██╔████╝██║     
"               ╚██╗  ██╝   ██║  ██║╚██╝ ██║    
"                 ╚███╝     ██║  ██║ ╚╝  ██║
"                  ╚═╝      ╚═╝  ╚═╝     ╚═╝
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIGURACAO DO VIM COMO IDE PARA PARA SCRIPT, PYTHON & RUST HASSEGA BY BLAU "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''"
" ==============================================================================
" 1. GERENCIADOR DE PLUGINS (Vim-Plug)
" ==============================================================================
call plug#begin('~/.vim/plugged')

" --- Temas --------------------------------------------------------------------
Plug 'ghifarit53/tokyonight-vim'
Plug 'gruvbox-community/gruvbox' " Novo: Plugin do Tema Gruvbox

" --- Explorador de Arquivos e Ícones ------------------------------------------
Plug 'preservim/nerdtree'      " Novo: Abre arquivos/pastas na lateral
Plug 'sickill/vim-monokai'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'agude/vim-eldar'
Plug 'ryanoasis/vim-devicons'  " Novo: Adiciona ícones de arquivos (deve vir por último)

" --- Suporte Avançado e Sintaxe Dinâmica para Python (Novo) ------------------
Plug 'vim-python/python-syntax' " Destaca sintaxe moderna do Python 3
" Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' } " Cores inteligentes para variáveis
Plug 'dense-analysis/ale'       "Ativa o ALE (Asynchronous Lint Engine)"

" ––– Programacao Rust———————————————————————————————————————————-
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ==============================================================================
" 2. CONFIGURAÇÕES DE CORES E TEMA (Melhorado)
" ==============================================================================
if has('termguicolors')
 set termguicolors
else
 set t_Co=256
endif

" Ativar demais temas
" colorscheme dracula
" colorscheme monokai
colorscheme eldar

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

"-------------  CAMINHOS  ------------------------------------------------------
set path=.,**
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

"-------------  QUEBRA DE LINHAS  ----------------------------------------------
set nowrap
set linebreak

"-------------  ALTERNAR QUEBRA DE LINE  --------------------------------------
map <F3> :set wrap!<cr>

"-------------  ABRIR TERMINAL  ------------------------------------------------  
map <F4> :term<cr>  "control D fecha terminal

"------------- ALTERNAR CARACTERES INVISIVEIS ----------------------------------
map <F6> :set list<cr>

"------------- EXIBE ESTATISTICAS DO ARQUIVO ----------------------------------
map  <F7> g<c-g>
imap <F7> <c-o>g<c-g>

"------------- ABRE DEBUGER NO TERMINAL ----------------------------------------
map <F8> :term gdb<cr>

"------------- EXECUTAR MAKE (REQUER MAKEFILE NO DIRETORIO ---------------------
map <F9> :term make<cr>

"------------- MAPEAMENTO DA TECLA DE ATALHO -----------------------------------
let mapleader = ' '

"------------- ATALHO PARA EXECUTAR RUN NO PYTHON (:!python3 %) ----------------
"  nnoremap <C-r> :!python3 % <cr>   (ver mapeamento com black linha  (*Mapeamento exclusivo para Python*)

"------------- ABRIR TERMINAL LADO DIREITO E ESQUERDO --------------------------
nnoremap <C-b> :vsp<cr>
nnoremap <C-d> :belowright<cr>

" Atalho para abrir/fechar o NERDTree com Control + N
nnoremap <C-n> :NERDTreeToggle<CR>

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
set listchars=tab:â€º-,space:Â·,trail:â—€,eol:â†²   " caracteres nao imprimiveis """""
set fillchars=vert:â”‚,fold:-,eob:~,lastline:@

"-------------  NUMERACOES LINHAS E CURSOR  ------------------------------------
set scrolloff=2
set cursorline

"-------------  MUDAR BLOCO PARA BARRA NO MODOS INS E VISUAL  -----------------
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"

"-------------  INDENTACAO & TABULACAO ---------------------------------------------------
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"-------------  AUTOMACOES PARA SHELL SCRIPT -----------------------------------
function! IniciarScriptShell()
    " Insere a hashbang na primeira linha
    call setline(1, '#!/bin/bash')
    " Adiciona uma linha em branco abaixo
    call append(1, '')
    " Move o cursor para a linha 2, coluna 1
    call cursor(2, 1)
    " Entra no modo de insercao
    startinsert
endfunction

augroup ShellScripting
    autocmd!
    " 1. Chama a funcao acima ao criar um arquivo .sh novo
    autocmd BufNewFile *.sh call IniciarScriptShell()

    " 2. Torna o script executavel automaticamente ao salvar pela primeira vez
    autocmd BufWritePost *.sh silent! !chmod +x %

    " 3. Roda o ShellCheck automaticamente (se instalado) ao salvar para exibir erros
    autocmd BufWritePost *.sh silent! make | redraw!
augroup END

"-------------  BUSCA COM CAIXA TEXTO DIFER. MAISC E MIN  ----------------------
set ignorecase
set smartcase
set incsearch
set hls
let @/ = ""

"-------------  ORTOGRAFIA  ----------------------------------------------------
set nospell
set spelllang=pt_br,en

"------------- MAPEAMENTO BASICO AUTOCOMPLETE ---------------------------------- 
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>

"------------- ALTERNAR CORRECAO ORTOGRAFICA ---------------------------------
map <F3> :set spell!<cr>

"------------- SELECAO COM SETAS UP E DOWN -------------------------------------
inoremap <expr> <up> pumvisible() ? '<c-p>' : '<up>'
inoremap <expr> <down> pumvisible() ? '<c-n>' : '<down>'

"------------- ACEITAR COM SETA DIREITA OU ENTER -----------------------------
inoremap <expr> <right> pumvisible() ? '<c-y>' : '<right>'
inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'

"-------------- CANCELAR COMPLETION COM SETA ESQUERDA ------------------------
inoremap <expr> <left> pumvisible() ? '<c-e>' : '<left>'

"--------------- HASHBANGS ----------------------------------------------------
function! Hashbangs()
    let hb = ['#!/bin/bash', '#!/usr/bin/env bash', '#!/bin/sh', '#!/usr/bin/awk -f']
    call complete(col('.'), hb)
    return ''
endfunction 
imap <c-F12> <c-r>=Hashbangs()<cr>

"------------- MENU SELVAGEM ---------------------------------------------------
set wildmenu
set wildmode=longest,full
set wildoptions=pum

"------------- BARRA DE STATUS -----------------------------------------------
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
    \ 'n' : 'Normal',
    \ 'no' : 'Normal-Operator Pending',
    \ 'v' : 'Visual',
    \ 'V' : 'V-Line',
    \ ' ' : 'V-Block',
    \ 's' : 'Select',
    \ 'S' : 'S-Line',
    \ ' ' : 'S-Block',
    \ 'i' : 'Insert',
    \ 'R' : 'Replace',
    \ 'Rv' : 'V-Replace',
    \ 'c' : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r' : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!' : 'Shell',
    \ 't' : 'Terminal'
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

"------------- ESQUEMA DE CORES ----------------------------------------------
"------------- FUNDO TRANSPARENTE --------------------------------------------
hi Normal guibg=NONE ctermbg=NONE

"------------- LINHA DO CURSOR -----------------------------------------------
hi CursorLine guibg=#2e2a24 """"""""202130

"------------- COMENTARIOS EM ITALICO ----------------------------------------
hi Comment cterm=italic gui=italic

"------------- DIVISAO VERTICAL DE JANELAS -----------------------------------
hi VertSplit ctermbg=NONE guibg=NONE ctermfg=7 guifg=#c1c2d0

"------------- BARRA DE ABAS -------------------------------------------------
hi TabLine guifg=#9192a0 guibg=#303140 gui=none
hi TabLineSel guifg=#a1a2b0 guibg=#101120 gui=bold
hi TabLineFill guifg=#9192a0 guibg=#303140 gui=none

"------------- SELECAO MODO VISIAL -------------------------------------------
hi Visual guifg=NONE guibg=#303140

"------------- HABILITAR O METODO DE MARCACAO PARA DOBRAMENTO CODIGO -----------
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim set foldlevelstart=30
    autocmd FileType vim setlocal foldmarker={{{,}}}
augroup END

" ============================================================================
" BACKUP AUTOMÁTICO AO FECHAR CONFIGURAÇÕES E O SCRIPT DE EVOLUÇÃO
" ============================================================================
augroup AutoVimBackup
    autocmd!
    autocmd BufWritePre *vimrc silent! !mkdir -p ~/vim_backups
    autocmd BufWritePre *vimrc execute "!cp % ~/vim_backups/" . substitute(expand('%:t'), '^\.', '', '') . "_auto_" . strftime('%Y-%m-%d_%Hh%M')
augroup END

" ==============================================================================
" RUST: PROGRAMAR E COMPILAR
" ==============================================================================
let g:rustfmt_autosave = 1 " Roda rustfmt ao salvar
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:cargo_makeprg_params = 'check' " :make usa cargo check por padrão
let g:coc_rust_analyzer_server_path = $HOME . '/.cargo/bin/rust-analyzer'

augroup RustAutoCmds
    autocmd!
    " Define makeprg pra arquivos .rs
    autocmd FileType rust compiler cargo
 
    " Habilita números e quebra só pra Rust
    autocmd FileType rust setlocal colorcolumn=100
 
    " Fecha quickfix ao sair do insert se estiver vazio
    autocmd InsertLeave *.rs cwindow
augroup END

" --- MAPEAMENTOS SÓ PRA RUST ---
autocmd FileType rust nnoremap <buffer> <F5> :RustRun<CR>
autocmd FileType rust nnoremap <buffer> <F6> :Cargo test<CR>
autocmd FileType rust nnoremap <buffer> <F9> :Cargo build --release<CR>
autocmd FileType rust nnoremap <buffer> <leader>cb :Cargo build<CR>
autocmd FileType rust nnoremap <buffer> <leader>cc :Cargo check<CR>
autocmd FileType rust nnoremap <buffer> <leader>cf :RustFmt<CR>
autocmd FileType rust nnoremap <buffer> <leader>ct :RustTest<CR>
autocmd FileType rust nnoremap <buffer> <leader>cr :RustRun 
" --- COC.NVIM PRA LSP RUST ---
autocmd FileType rust nmap <buffer> gd <Plug>(coc-definition)
autocmd FileType rust nmap <buffer> gr <Plug>(coc-references)
autocmd FileType rust nmap <buffer> K :call CocActionAsync('doHover')<CR>
autocmd FileType rust nmap <buffer> <leader>rn <Plug>(coc-rename)
autocmd FileType rust nmap <buffer> <leader>a <Plug>(coc-codeaction)
autocmd FileType rust nmap <buffer> <leader>f <Plug>(coc-format)
autocmd FileType rust nnoremap <buffer> <leader>e :CocDiagnostics<CR> 

" ==============================================================================
" PYTHON: PROGRAMAR, AUTOMAÇÃO E COMPILAÇÃO (NOVO COMPLETO)
" ==============================================================================
" Define o flake8 como o linter padrão para Python
let g:ale_linters = {
\   'python': ['flake8'],
\}

" Diz ao Vim exatamente onde encontrar o flake8 instalado pelo pipx
let g:ale_python_flake8_executable = '~/.local/bin/flake8'

" Customização visual: Ícones na lateral para erros e avisos
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" Atalhos para navegar entre os erros apontados pelo flake8
autocmd FileType python nnoremap <silent> <buffer> <C-j> :ALENextWrap<CR>
autocmd FileType python nnoremap <silent> <buffer> <C-k> :ALEPreviousWrap<CR>

augroup PythonAutoCmds
    autocmd!
    " Aplica as regras de indentação PEP 8 de forma estrita em arquivos .py
    " IMPORTANTE: 'nosmartindent' evita problemas com comentários '#' jogados no início da linha
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab textwidth=79 colorcolumn=80 nosmartindent
augroup END

" --- INTEGRAÇÃO COM O BLACK FORMATTER (PIPX) ---
" Cria os comandos :F e :Format para indentar e formatar com Black, recarregando a tela em seguida
autocmd FileType python command! -buffer -nargs=0 F silent !~/.local/bin/black -q % | edit!
autocmd FileType python command! -buffer -nargs=0 Format silent !~/.local/bin/black -q % | edit!

" --- MAPEAMENTOS EXCLUSIVOS PARA PYTHON ---
" Control + R = Primeiro indenta/formata com o Black e depois executa o script Python
autocmd FileType python nnoremap <buffer> <C-r> :F<CR>:w<CR>:!python3 %<CR>

" <leader>py = Salva o script e executa de forma direta no shell tradicional externo
autocmd FileType python nnoremap <buffer> <leader>py :w<CR>:!python3 %<CR>

" Integração completa com o motor CoC para pular direto para funções/métodos Python
autocmd FileType python nmap <buffer> gd <Plug>(coc-definition)
autocmd FileType python nmap <buffer> gr <Plug>(coc-references)

" --- GERAÇÃO AUTOMÁTICA DE CABEÇALHOS EM NOVOS ARQUIVOS ---
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
    " Insere a hashbang e esqueleto inicial automaticamente se o arquivo .py for novo
    autocmd BufNewFile *.py call IniciarScriptPython()
    " Garante que o script ganhe permissão de execução nativa +x no CachyOS ao salvar
    autocmd BufWritePost *.py silent! !chmod +x %
augroup END

" ==============================================================================
" CONFIGURAÇÃO GERAL COMPARTILHADA DO COC.NVIM
" ==============================================================================
set updatetime=300
set signcolumn=yes
autocmd CursorHold * silent call CocActionAsync('highlight')
inoremap <silent><expr> . coc#refresh()
inoremap <silent><expr> :: coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" ==============================================================================
" OLLAMA VIA CURL - FUNCIONA NO VIM PURO
" ==============================================================================
function! OllamaFix() range
    let l:code = join(getline(a:firstline, a:lastline), "\n")
    let l:prompt = "Analisa e corrige esse código. Retorna só o código corrigido com # CORREÇÃO: nos locais alterados e depois liste as linhas corrigidas:\n\n" . l:code
    let l:json = json_encode({'model': 'qwen-coder-br', 'prompt': l:prompt, 'stream': v:false})
    let l:cmd = "curl -s http://localhost:11434/api/generate -d " . shellescape(l:json)
    echo "Corrigindo com qwen-coder-br..."
    let l:response = system(l:cmd)
    let l:output = json_decode(l:response)['response']
    execute a:firstline . "," . a:lastline . "delete"
    call append(a:firstline-1, split(l:output, "\n"))
endfunction

function! OllamaAsk()
    let l:prompt = input('Pergunta pro qwen-coder-br: ')
    if l:prompt == '' | return | endif
    let l:json = json_encode({'model': 'qwen-coder-br', 'prompt': l:prompt, 'stream': v:false})
    let l:cmd = "curl -s http://localhost:11434/api/generate -d " . shellescape(l:json)
    echo "Pensando..."
    let l:response = system(l:cmd)
    let l:output = json_decode(l:response)['response']
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile
    call append(0, split(l:output, "\n"))
endfunction
