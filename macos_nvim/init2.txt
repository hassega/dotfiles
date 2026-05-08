"==============================================================================
" CONFIGURAÇÃO NEOVIM FINAL - CERBERO (COBOL + PYTHON + PUG) - UNIVERSAL
"==============================================================================

" 1. CONFIGURAÇÕES BÁSICAS
set mouse=a                     " Ativa o suporte ao mouse em todos os modos
set number relativenumber         " Exibe números absolutos e relativos das linhas
set termguicolors                 " Usa cores verdadeiras do terminal se disponível
set laststatus=2                  " Mantém a barra de status visível sempre
syntax on                       " Ativa a sintaxe de colorização
filetype plugin indent on         " Habilita plugins e indentação específicos para cada tipo de arquivo

" --- CONFIGURAÇÃO CORRIGIDA DE WRAP EXATO COM A COLUNA ORIGINAL ---
set wrap                        " Quebra linhas longas para caber na janela
set linebreak                   " Quebra linhas em pontos razoáveis, evitando palavras cortadas
set breakindent                 " Mantém a indentação ao quebrar linhas
set breakindentopt=min:20       " Define o mínimo de espaço necessário para a indentação

" Integração total com o teclado/mouse do macOS
set clipboard=unnamedplus         " Usa o clipboard do sistema para copiar/colar

" 2. GERENCIADOR DE PLUGINS (Identifica automaticamente sua pasta pessoal)
call plug#begin(expand('~/.local/share/nvim/site/plugged'))
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Parser de árvore sintática para melhor destaque e formatação
Plug 'digitaltoad/vim-pug'                               " Suporte a sintaxe Pug (Jade)
Plug 'lukas-reineke/indent-blankline.nvim'               " Linhas verticais para destacar a indentação
Plug 'nvim-lua/plenary.nvim'                             " Biblioteca Lua para uso geral no Neovim
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' } " Fuzzy finder integrado

" Gerenciador de Arquivos Lateral
Plug 'nvim-tree/nvim-web-devicons'                       " Ícones para arquivos no NvimTree
Plug 'nvim-tree/nvim-tree.lua'                           " Plugin de árvore de arquivos lateral
call plug#end()

let g:loaded_netrw = 1                                    " Desativa o explorador de arquivos interno do Neovim
let g:loaded_netrwPlugin = 1                              " Desativa o plugin netrw do Neovim

" 3. CORES E INTERFACE (TEMA BLUE)
silent! colorscheme blue                                  " Define o tema azul
hi Normal guibg=NONE ctermbg=NONE                         " Remove fundo padrão para a cor normal
hi Terminal guibg=NONE ctermbg=NONE                      " Remove fundo padrão para terminais
hi EndOfBuffer guibg=NONE ctermbg=NONE                   " Remove fundo padrão após o conteúdo do arquivo

"------------- RÉGUAS DE COLUNA EM VINHO ---------------------
set colorcolumn=7,8,12,72                                 " Define colunas de destaque em 7, 8, 12 e 72
highlight ColorColumn guibg=#5f0000 ctermbg=52             " Define a cor das colunas destacadas

" --- INDENTAÇÃO AZUL DE ALTO CONTRASTE ---
highlight IblIndent guifg=#51afef gui=nocombine           " Cor da indentação
highlight IblScope guifg=#00ffff gui=nocombine            " Cor do escopo de indentação

lua << LUA
-- 1. Configuração compatível com a versão instalada do indent-blankline
local status_ibl, ibl = pcall(require, "ibl")
if status_ibl then
    ibl.setup {
        indent = {
            char = "│",                                     -- Caractere usado para indentação
            highlight = { "IblIndent" }                     -- Highlight para a indentação
        },
        scope = {
            enabled = true,                                -- Habilita o escopo de indentação
            char = "┃",                                     -- Caractere usado para o escopo
            highlight = { "IblScope" }                      -- Highlight para o escopo
        },
        exclude = {
            filetypes = { "help", "terminal", "dashboard", "NvimTree" } -- Tipos de arquivos a serem excluídos
        }
    }
else
    -- Fallback para a versão antiga do indent-blankline (v2)
    vim.opt.list = true                                   -- Exibe caracteres especiais
    vim.g.indent_blankline_char = "│"                     -- Caractere usado para indentação
    vim.g.indent_blankline_show_current_context = 1       -- Destaca o contexto atual de indentação
    vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "NvimTree" } -- Tipos de arquivos a serem excluídos
end

-- 2. Configuração segura da árvore lateral (NvimTree)
local status_nt, nvim_tree = pcall(require, "nvim-tree")
if status_nt then
    nvim_tree.setup({
        sort = { sorter = "case_sensitive" },              -- Ordena arquivos de forma case-sensitive
        view = { width = 32, side = "left" },              -- Configurações de visualização da árvore
        renderer = { group_empty = true },                 -- Agrupa pastas vazias
        filters = { dotfiles = true, custom = { "^\\.git$", "^\\.cache$" } }, -- Filtros para arquivos ocultos
        git = { enable = false },                          -- Desativa integração com o Git
        sync_root_with_cwd = true,                         -- Sincroniza a raiz da árvore com o diretório de trabalho atual
        respect_buf_cwd = false,                           -- Não respeita o diretório de trabalho do buffer atual
        update_focused_file = { enable = true, update_root = false } -- Atualiza o arquivo focado
    })
end

-- 3. Configuração do Tree-sitter
local status_ts, ts_configs = pcall(require, "nvim-treesitter.configs")
if status_ts then
    ts_configs.setup({
        ensure_installed = { "cobol", "python", "lua", "vim", "vimdoc" }, -- Linguagens a serem instaladas
        highlight = {
            enable = true,                                 -- Habilita destaque sintático
            additional_vim_regex_highlighting = false,     -- Desativa realce adicional do Vim
        },
    })
end
LUA

" 4. CONFIGURAÇÕES COBOL
let g:cobol_autoupper = 0                                 " Desativa a formatação automática para maiúsculas no Cobol
let g:cobol_fold = 0                                      " Desativa o dobrar de seções do Cobol

" 5. BARRA DE STATUS COLORIDA
hi StatusLine cterm=NONE ctermfg=0 ctermbg=7 guibg=#C1C2D0 guifg=#000000 " Define a cor da barra de status normal
autocmd InsertEnter * hi StatusLine guibg=#7BC86F guifg=#000000  " Altera a cor da barra de status quando em modo de inserção
autocmd InsertLeave * hi StatusLine guibg=#C1C2D0 guifg=#000000  " Restaura a cor da barra de status ao sair do modo de inserção
set statusline=%#StatusLine#\ %{toupper(mode())}\ \|\ %f%m\ \|\ %l/%L\ \|\ Col:\ %c " Formatação da barra de status

" 6. ATALHOS GERAIS
let mapleader = ' '                                       " Define o líder de mapeamento como espaço
nnoremap <Tab> <C-w>w                                    " Muda para a próxima janela com Tab
nnoremap <S-Tab> <C-w>W                                  " Muda para a janela anterior com Shift+Tab
nnoremap <C-b> :vsp<cr>                                   " Cria uma nova janela vertical
nnoremap <C-d> :belowright split<cr>                    " Cria uma nova janela horizontal abaixo
nnoremap <C-s> :w!<cr>                                    " Salva o arquivo forçadamente com Ctrl+s
nnoremap <C-q> :q<cr>                                     " Fecha o Neovim com Ctrl+q
nnoremap <C-x> :+y<cr>                                   " Copia a linha atual para a área de transferência com Ctrl+x
nnoremap <C-v> :+p<cr>                                   " Cola do clipboard com Ctrl+v
nnoremap <C-c> :y<cr>                                     " Copia a linha atual para o buffer vim com Ctrl+c
nnoremap <F6> :set list!<cr>                               " Alterna entre exibir/esconder caracteres especiais com F6

" Atalhos de navegação e busca (Usa expand('~') para ser universal)
nnoremap <C-p> :lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('~/COBOL/cob') })<CR>
nnoremap <C-n> :NvimTreeOpen<CR>:wincmd l<CR>

" --- ATALHOS UNIVERSAIS PARA FECHAR O TERMINAL ---
tnoremap <C-q> <C-\><C-n>:q!<CR>                          " Fecha o terminal integrado com Ctrl+q
tnoremap <Esc> <C-\><C-n>                                  " Sai do modo de terminal com Esc
autocmd FileType terminal nnoremap <buffer> q :q!<CR>      " Mapeia 'q' para fechar o terminal no modo normal

" --- ATALHOS PARA SIMBOLOS ---
inoremap ( ()<left>                                        " Insere parênteses e move o cursor dentro deles
inoremap [ []<left>                                        " Insere colchetes e move o cursor dentro deles
inoremap { {}<left>                                        " Insere chaves e move o cursor dentro delas
inoremap " ""<left>                                        " Insere aspas duplas e move o cursor dentro delas
inoremap ' ''<left>                                        " Insere aspas simples e move o cursor dentro delas

" 7. AMBIENTE PYTHON
nnoremap <C-r> :w<CR>:botright split \| term python3 %<CR> " Executa o arquivo Python atual em um terminal dividido com Ctrl+r
nnoremap <F5> :w<CR>:botright split \| term python3 %<CR>  " Executa o arquivo Python atual em um terminal dividido com F5

" 8. AMBIENTE COBOL
augroup cobol_env
    autocmd!
    autocmd FileType cobol setlocal colorcolumn=7,8,12,72 textwidth=72 " Configura colunas de destaque e largura máxima para o Cobol
    autocmd FileType cobol nnoremap <buffer> <F10> :update | execute "botright split | term ~/COBOL/setup_cobol.sh '" . expand('%:p') . "'" <CR>
augroup END

autocmd TermOpen * startinsert                            " Entra no modo de inserção ao abrir um terminal
tnoremap <Esc> <C-\><C-n>:q<CR>                          " Sai do terminal integrado com Esc

" 9. MÁSCARA AUTOMÁTICA COBOL
function! CreateCobolTemplate()
    if line('$') == 1 && getline(1) == ''
        call append(0, [
            \ "       IDENTIFICATION DIVISION.",
            \ "       PROGRAM-ID. " . toupper(expand("%:t:r")) . ".",
            \ "       AUTHOR. CERBERO.",
            \ "",
            \ "       ENVIRONMENT DIVISION.",
            \ "       DATA DIVISION.",
            \ "       WORKING-STORAGE SECTION.",
            \ "",
            \ "       PROCEDURE DIVISION.",
            \ "       MAIN-PROCEDURE.",
            \ "           DISPLAY 'OLA NEOVIM'.",
            \ "           STOP RUN.",
            \ "       END PROGRAM " . toupper(expand("%:t:r")) . "."
            \ ])
        call cursor(9, 8)                                   " Move o cursor para a posição inicial no template
    endif
endfunction

autocmd BufNewFile *.cob,*.cbl call CreateCobolTemplate() " Cria um template de Cobol ao criar um novo arquivo .cob ou .cbl

set guicursor=n-v-c-i:block-Cursor                        " Define o cursor como bloco em modos normal, visual e inserção
highlight Cursor guibg=#ffff00 guifg=black                 " Define a cor do cursor

" ==============================================================================
" 10. EXTRAÇÃO DE EXAMES E EVOLUÇÃO MÉDICA
" ==============================================================================
function! GerarEvolucaoMedica()
    let l:paciente = input('Digite o nome da pasta do paciente: ') " Solicita ao usuário o nome da pasta do paciente
    if l:paciente == ''
        echo "\nOperação cancelada: Nome do paciente em branco."
        return                                                  " Sai da função se o nome estiver em branco
    endif

    " Identifica os caminhos baseado na sua Home
    let l:script = expand('~/EXAMESPDF/gerar_evolucao.py')     " Caminho para o script Python
    let l:pasta_paciente = expand('~/EXAMESPDF/') . l:paciente  " Caminho da pasta do paciente
    let l:arquivo_txt = l:pasta_paciente . '/evolucao_' . l:paciente . '.txt' " Caminho do arquivo de evolução

    " 1. Verifica se a pasta existe antes de executar
    if !isdirectory(l:pasta_paciente)
        echo "\nErro: A pasta do paciente '" . l:paciente . "' não existe na pasta de exames."
        return                                                  " Sai da função se a pasta não existir
    endif

    " 2. Executa o script python passando o nome do paciente
    let l:cmd = 'python3 ' . l:script . ' "' . l:paciente . '"'
    let l:output = system(l:cmd)

    if v:shell_error
        echo "\nErro ao executar o script Python."
        return                                                  " Sai da função se houver erro no script
    endif

    " 3. Insere o conteúdo diretamente sob o cursor se o arquivo existir
    if filereadable(l:arquivo_txt)
        let l:linhas = readfile(l:arquivo_txt)                  " Lê as linhas do arquivo de evolução
        call append(line('.'), l:linhas)                        " Insere as linhas no buffer atual
        echo "\nEvolução inserida com sucesso!"
    else
        echo "\nArquivo de evolução não encontrado em: " . l:arquivo_txt " Informa que o arquivo não foi encontrado
    endif
endfunction

" Atalho para gerar evolução (Espaço + e + v)
nnoremap <leader>ev :call GerarEvolucaoMedica()<CR>        " Mapeia Espaço+e+v para chamar a função de geração de evolução
