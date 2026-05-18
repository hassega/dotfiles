"=============================================================================
	" CONFIGURAÇÃO NEOVIM FINAL - CERBERO (M3 MAX) - VERSÃO CORRIGIDA
"==============================================================================
let g:python3_host_prog = expand('~/EXAMESPDF/venv/bin/python')
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

set mouse=a
set number relativenumber
set termguicolors
set laststatus=2
syntax on
filetype plugin indent on
set clipboard=unnamedplus
set expandtab

"01. --- WRAP VISUAL GERAL ---
set wrap
set linebreak
set breakindent
set breakindentopt=min:20

"02. --- GERENCIADOR DE PLUGINS ---
call plug#begin(expand('~/.local/share/nvim/site/plugged'))
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'digitaltoad/vim-pug'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'L3MON4D3/LuaSnip'
Plug 'David-Kunz/gen.nvim'
" Adicione esta linha junto aos outros blocos de Plug
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

call plug#end()

"03.CORES E INTERFACE
set termguicolors
let g:tokyonight_style = "moon" " Opções: storm, night, moon, day

" Aplica o tema Tokyo Night
colorscheme tokyonight

" Garante a transparência do fundo que você já utilizava
hi Normal guibg=NONE
hi NonText guibg=NONE
hi NormalNC guibg=NONE

" Suas marcações de colunas médicas e margens personalizadas
set colorcolumn=7,8,12,72
highlight ColorColumn guibg=#5f0000 ctermbg=52
highlight IblIndent guifg=#51afef gui=nocombine
highlight IblScope guifg=#00ffff gui=nocombine
set guicursor=n-v-c-i:block-Cursor
highlight Cursor guibg=#ffff00 guifg=black

" --- INÍCIO DO BLOCO LUA PARA PLUGINS ---
lua << LUA

-- 04. --- MASON & LSP (Gerenciador de Servidores)
local status_mason, mason = pcall(require, "mason")
local status_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
local status_lspconfig, lspconfig = pcall(require, "lspconfig")

if status_mason and status_mason_lsp and status_lspconfig then
    mason.setup()
    mason_lsp.setup({
        ensure_installed = { "cobol_ls", "pyright", "rust_analyzer" },
        handlers = {
            function(server_name)
                lspconfig[server_name].setup {}
            end
        }
    })
end

-- 05. --- AUTOCOMPLETE (CMP)
local status_cmp, cmp = pcall(require, "cmp")
local status_luasnip, luasnip = pcall(require, "luasnip")

if status_cmp and status_luasnip then
    cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'buffer' } })
    })
end

-- 06. --- INTERFACE (Nvim-Tree, Treesitter)
local status_tree, nvim_tree = pcall(require, "nvim-tree")
if status_tree then
    nvim_tree.setup({ sync_root_with_cwd = true })
end

local status_ts, ts = pcall(require, "nvim-treesitter.configs")
if status_ts then
    ts.setup({
        ensure_installed = { "cobol", "python", "lua", "vim", "vimdoc", "rust" },
        highlight = { enable = true },
        indent = { enable = true }
    })
end

-- 07. --- CONFIGURAÇÃO DOS PONTINHOS E LINHA AZUL (Indent-Blankline)
local status_ibl, ibl = pcall(require, "ibl")
if status_ibl then
    -- Define os caracteres invisíveis (os pontinhos)
    vim.opt.list = true
    vim.opt.listchars:append({ space = "·" }) -- Define o ponto para espaços

    ibl.setup {
        indent = {
            char = "│",                  -- A linha vertical descendente
            highlight = { "IblIndent" }, -- Usa a cor azul (ou ciano) definida no seu highlight
        },
        whitespace = {
            highlight = { "IblIndent" }, -- Aplica a cor também nos pontinhos
            remove_blankline_trail = false,
        },
        scope = { enabled = false },     -- Desativa o escopo para focar na indentação pura
    }
end

-- 08. --- TELESCOPE (Busca)
local status_tel, telescope = pcall(require, "telescope")
if status_tel then
    telescope.setup({
        defaults = {
            preview = {
                treesitter = false,
            },
        },
    })
end

-- 09. --- OLLAMA CODER
require('gen').setup({
  model = "qwen2.5-coder:32b-instruct-q4_K_M", -- Nome exato do Ollama
  display_mode = "float", -- Janela flutuante (bom para o seu setup de colunas)
  show_model = true,
  width = 80,
  height = 25,
})

LUA

"10. ---. ATALHOS GERAIS ---
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap <C-b> :vsp<cr>
nnoremap <C-d> :belowright split<cr>
nnoremap <C-s> :w!<cr>
nnoremap <C-q> :q<cr>
" Agora o Ctrl+n dispara a análise clínica e não mais a árvore de arquivos
nnoremap <C-n> :call GerarEvolucaoMedica()<CR>

nnoremap <C-p> :lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('~/COBOL/cob') })<CR>

"11.AMBIENTE PYTHON
nnoremap <C-r>: update <bar> botright split <bar> term python3 %<CR>
nnoremap <F5>: update <bar> botright split <bar> term python3 %<CR>
tnoremap <Esc> <C-\><C-n>
autocmd FileType rust nnoremap <buffer> <F5> :update <bar> botright split <bar> term cargo run<CR>
autocmd Termopen * startinsert

"12. ---. AMBIENTE COBOL (COMPILAÇÃO E WRAP FÍSICO) ---
let g:cobol_autoupper = 0
let g:cobol_fold = 0

function! RodarCobol()
    write
    let l:arquivo_cob = expand('%:p')
    let l:script_sh = expand('~/COBOL/setup_cobol.sh')
    let l:comando = "botright split | term " . l:script_sh . " '" . l:arquivo_cob . "'"
    execute l:comando
endfunction

augroup cobol_logic
    autocmd!
    "12.1. Unificação: Aplica margem 72, wrap físico (t) e autoindent em um só bloco
    "Adicione isso na seção de COBOL:
    autocmd FileType cobol setlocal textwidth=72
    autocmd FileType cobol setlocal formatoptions+=tc autoindent
    autocmd FileType cobol setlocal wrap linebreak colorcolumn=7,8,12,72
    
    "12.2. Configurações para Indentação em Escada (Estilo Python)
    """"" Define que o Tab terá 4 espaços e converterá tabs em espaços para manter o alinhamento
    autocmd FileType cobol setlocal shiftwidth=4 tabstop=4 expandtab
    
    "12.3. Atalho F10
    autocmd FileType cobol nnoremap <buffer> <F10> :call RodarCobol()<CR>
augroup END

"13. ---. TEMPLATE COBOL ---
function! CreateCobolTemplate()
    if line('$') == 1 && getline(1) == ''
        let l:prog = toupper(expand("%:t:r"))
        call append(0, [
            \ "       IDENTIFICATION DIVISION.",
            \ "       PROGRAM-ID. " . l:prog . ".",
            \ "       AUTHOR. CERBERO.",
            \ "      *",
            \ "       ENVIRONMENT DIVISION.",
            \ "      *",
            \ "       DATA DIVISION.",
            \ "       WORKING-STORAGE SECTION.",
            \ "      *",
            \ "       PROCEDURE DIVISION.",
            \ "       MAIN-PROCEDURE.",
            \ "           DISPLAY 'OLA NEOVIM'.",
            \ "           STOP RUN.",
            \ "       END PROGRAM " . l:prog . "."
            \ ])
        call cursor(12, 11)
    endif
endfunction

autocmd BufNewFile *.cob,*.cbl call CreateCobolTemplate()

"14. ---. EVOLUÇÃO MÉDICA (Versão Corrigida) ---
function! GerarEvolucaoMedica()
    let l:paciente = input("Nome do Paciente: ")
    if l:paciente == "" | return | endif
    
    " CORREÇÃO DA LINHA 195/196:
    let l:cmd = "python3 ~/EXAMESPDF/gerar_evolucao.py '" . l:paciente . "'"
    
    echo "\nProcessando exames..."
    silent call system(l:cmd)

    let l:p_slug = substitute(l:paciente, ' ', '_', 'g')
    let l:arquivo = expand("~/EXAMESPDF/") . l:paciente . "/evolucao_" . l:paciente . ".txt"
    let l:arquivo_slug = expand("~/EXAMESPDF/") . l:p_slug . "/evolucao_" . l:p_slug . ".txt"

    if filereadable(l:arquivo)
        execute "only | edit " . fnameescape(l:arquivo)
    elseif filereadable(l:arquivo_slug)
        execute "only | edit " . fnameescape(l:arquivo_slug)
    else
        echo "\nArquivo não achado! Verifique a pasta em ~/EXAMESPDF"
    endif
endfunction

" ==============================================================
"15. ---. CONFIGURAÇÃO FINAL DE ATALHOS - CERBERO
" ==============================================================

" 16. ---. DEFINE A TECLA DE ESPACO COMO LEADER
let mapleader = " "

" 18. ---. EVOLUÇÃO MÉDICA (Chama o novo script Python 1983)
" Atalho: Espaço + e + v
nnoremap <leader>ev :call GerarEvolucaoMedica()<CR>

" 19. ---. CONFIGURAÇÃO (Abre o init.vim em divisão vertical)
" Atalho: Espaço + c + v (de Config Vim)
" Use o caminho completo para evitar telas em branco
nnoremap <leader>cv :edit ~/.config/nvim/init.vim<cr>

" 20. --. RECARREGAR (Aplica mudanças do init.vim sem fechar)
" Atalho: Espaço + s + v
nnoremap <leader>sv :source $MYVIMRC<cr>

" 21. -- Executa o script que está guardado dentro da pasta do programa
" Atalho: Espaço + b + g
nnoremap <leader>bg :silent !~/BLOODGAS/rodar_bg.sh<CR>

" 22. -- Executa o script que roda o Python correto
" Atalho: Espaço + r roda o script com o Python correto
nnoremap <leader>r :split \| terminal ~/EXAMESPDF/venv/bin/python ~/EXAMESPDF/gerar_evolucao.py TUDO<CR>

" 23. --. BACKUP (Comando :Bkp para rodar seu script de backup)
" Uso: Digite :Bkp no modo normal
command! Bkp :!bkp
