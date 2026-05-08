"==============================================================================
" CONFIGURAÇÃO NEOVIM FINAL - CERBERO - (SOLUÇÃO SEM LSPCONFIG MANUAL)
"==============================================================================

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

set mouse=a
set number relativenumber
set termguicolors
set laststatus=2
syntax on
filetype plugin indent on
set clipboard=unnamedplus
let mapleader = ' '

" WRAP GARANTIDO
set wrap
set linebreak
set breakindent
set breakindentopt=min:20

call plug#begin(expand('~/.local/share/nvim/site/plugged'))
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'digitaltoad/vim-pug'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'L3MON4D3/LuaSnip'
call plug#end()

silent! colorscheme blue
hi Normal guibg=NONE
set colorcolumn=7,8,12,72
highlight ColorColumn guibg=#5f0000 ctermbg=52
highlight IblIndent guifg=#51afef gui=nocombine
highlight IblScope guifg=#00ffff gui=nocombine
set guicursor=n-v-c-i:block-Cursor
highlight Cursor guibg=#ffff00 guifg=black

lua << LUA
-- 1. Mason (Instalador)
require("mason").setup()

-- 2. Mason-LSPConfig (Configura automaticamente SEM chamar require('lspconfig'))
require("mason-lspconfig").setup({
    ensure_installed = { "cobol_ls" },
    handlers = {
        function (server_name) -- Handler padrão configura todos os instalados
            require("lspconfig")[server_name].setup {}
        end,
    }
})

-- 3. Autocomplete (CMP)
local cmp = require'cmp'
cmp.setup({
    snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'buffer' } })
})

require("nvim-tree").setup({ sync_root_with_cwd = true })

local status_ts, ts = pcall(require, "nvim-treesitter.configs")
if status_ts then
    ts.setup({
        ensure_installed = { "cobol", "python", "lua", "vim", "vimdoc" },
        highlight = { enable = true }
    })
end

local status_ibl, ibl = pcall(require, "ibl")
if status_ibl then ibl.setup() end
LUA

" --- 4.  ATALHOS GERAIS ---
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap <C-b> :vsp<cr>
nnoremap <C-d> :belowright split<cr>
nnoremap <C-s> :w!<cr>
nnoremap <C-q> :q<cr>
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-p> :lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('~/COBOL/cob') })<CR>

" --- 5. AMBIENTE PYTHON ---
nnoremap <C-r> :update <bar> botright split <bar> term python3 %<CR>
nnoremap <F5> :update <bar> botright split <bar> term python3 %<CR>
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * startinsert

" --- 6. AMBIENTE COBOL (WRAP 72) ---
let g:cobol_autoupper = 0
let g:cobol_fold = 0

" 7. AMBIENTE COBOL (Compilação e Execução)
function! RodarCobol()
    " 1. Salva o arquivo atual de forma silenciosa
    write
    
    " 2. Pega o caminho absoluto do arquivo e do script
    let l:arquivo_cob = expand('%:p')
    let l:script_sh = expand('~/COBOL/setup_cobol.sh')
    
    " 3. Monta o comando de terminal (botright split abre embaixo)
    " Usamos <bar> para separar os comandos internos do execute
    let l:comando = "botright split | term " . l:script_sh . " '" . l:arquivo_cob . "'"
    
    execute l:comando
endfunction

augroup cobol_env
    autocmd!
    
    " 4.  Configurações visuais e de wrap na coluna 72
    autocmd FileType cobol setlocal wrap linebreak textwidth=72 colorcolumn=7,8,12,72
    autocmd FileType cobol setlocal formatoptions+=tc

" 8. CONFIGURAÇÃO DE WRAP FÍSICO PARA COBOL ---
augroup cobol_wrap
    autocmd!
    " 1. Define o limite na coluna 72
    autocmd FileType cobol setlocal textwidth=72
    " t: wrap automático de texto / c: wrap de comentários
    autocmd FileType cobol setlocal formatoptions+=tc
    " 2. Garante que ao quebrar a linha, ele respeite a indentação (coluna 8 ou 12)
    autocmd FileType cobol setlocal autoindent
set textwidth=72
set formatoptions+=t
set autoindent
augroup END

" 10.MAPEAMENTO DO F10 CHAMANDO A FUNCAO CORRIGIDA
    autocmd FileType cobol nnoremap <buffer> <F10> :call RodarCobol()<CR>
augroup END

" 11.MÁSCARA AUTOMÁTICA COBOL (Alinhada nas Colunas 8 e 12)
function! CreateCobolTemplate()
    if line('$') == 1 && getline(1) == ''
        let l:prog = toupper(expand("%:t:r"))
        call append(0, ["       IDENTIFICATION DIVISION.", "       PROGRAM-ID. " . l:prog . ".", "       AUTHOR. CERBERO.", "       *", "       ENVIRONMENT DIVISION.", "       *", "       DATA DIVISION.", "       WORKING-STORAGE SECTION.", "       *", "       PROCEDURE DIVISION.", "       MAIN-PROCEDURE.", "           DISPLAY 'OLA NEOVIM'.", "           STOP RUN.", "       END PROGRAM " . l:prog . "."])
        call cursor(9, 11)
    endif
endfunction

autocmd BufNewFile *.cob,*.cbl call CreateCobolTemplate()

" 12.EVOLUÇÃO MÉDICA (Versão Robusta para M3 Max com Underlines) ---
function! GerarEvolucaoMedica()
    let l:paciente = input('Nome do Paciente: ')
    if l:paciente == '' | return | endif

    let l:data = input('Data do Exame (DD/MM/AAAA): ')
    if l:data == '' | return | endif

    " 1.  CONVERSÃO PARA UNDERLINES (Para bater com o seu ls -F)
    let l:paciente_und = substitute(l:paciente, ' ', '_', 'g')
    let l:data_slug = substitute(l:data, '/', '-', 'g')

    let l:script = expand('~/EXAMESPDF/gerar_evolucao.py')
    " 2. O CAMINHO DO TXT AGORA USA O NOME COM UNDERLINES
    let l:pasta_paciente = expand('~/EXAMESPDF/') . l:paciente_und
    let l:arquivo_txt = l:pasta_paciente . '/evolucao_' . l:paciente_und . '_' . l:data_slug . '.txt'

    echo "\nProcessando..."

    " 3. O COMANDO PYTHON ENVIA O NOME ORIGINAL (o script Python cuidará do resto)
    let l:cmd = 'python3 ' . shellescape(l:script) . ' ' . shellescape(l:paciente) . ' ' . shellescape(l:data)
    
    let l:res = system(l:cmd)

    if filereadable(l:arquivo_txt)
        let l:linhas = readfile(l:arquivo_txt)
        call append(line('.'), l:linhas)
        
    " 4. APAGA O ARQUIVO TEMPORARIO APOS INSERCAO
        call delete(l:arquivo_txt)
        
        echo "\nSucesso! Evolução de " . l:paciente . " inserida."
    else
        echo "\nErro do Script ou Pasta não encontrada: " . l:res
        echo "Tentado em: " . l:arquivo_txt
    endif
endfunction

nnoremap <leader>ev :call GerarEvolucaoMedica()<CR>
