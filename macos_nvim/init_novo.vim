"==============================================================================
" CONFIGURAÇÃO NEOVIM FINAL - CERBERO - (M3 MAX EDITION)
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

" --- VISUAL E WRAP ---
set wrap
set linebreak
set breakindent
set breakindentopt=min:20

" --- GERENCIADOR DE PLUGINS ---
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

" --- CORES E CURSOR ---
silent! colorscheme blue
hi Normal guibg=NONE
set colorcolumn=7,8,12,72
highlight ColorColumn guibg=#5f0000 ctermbg=52
highlight IblIndent guifg=#51afef gui=nocombine
highlight IblScope guifg=#00ffff gui=nocombine
set guicursor=n-v-c-i:block-Cursor
highlight Cursor guibg=#ffff00 guifg=black

lua << LUA
-- 1. Mason (LSP Manager)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "cobol_ls" },
    handlers = {
        function (server_name)
            require("lspconfig")[server_name].setup {}
        end,
    }
})

-- 2. Autocomplete (CMP)
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

-- 3. Plugins UI
require("nvim-tree").setup({ sync_root_with_cwd = true })

require("nvim-treesitter.configs").setup({
    ensure_installed = { "cobol", "python", "lua", "vim", "vimdoc" },
    highlight = { enable = true },
    indent = { enable = true }
})

require("ibl").setup()
LUA

" --- ATALHOS GERAIS ---
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap <C-b> :vsp<cr>
nnoremap <C-d> :belowright split<cr>
nnoremap <C-s> :w!<cr>
nnoremap <C-q> :q<cr>
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-p> :lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('~/COBOL/cob') })<CR>

" --- AMBIENTE PYTHON ---
nnoremap <C-r> :update <bar> botright split <bar> term python3 %<CR>
nnoremap <F5> :update <bar> botright split <bar> term python3 %<CR>
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * startinsert

" --- AMBIENTE COBOL (Lógica e Compilação) ---
let g:cobol_autoupper = 0
let g:cobol_fold = 0

function! RodarCobol()
    write
    let l:arquivo_cob = expand('%:p')
    let l:script_sh = expand('~/COBOL/setup_cobol.sh')
    let l:comando = "botright split | term " . l:script_sh . " '" . l:arquivo_cob . "'"
    execute l:comando
endfunction

augroup cobol_env
    autocmd!
    autocmd FileType cobol setlocal wrap linebreak textwidth=72 colorcolumn=7,8,12,72
    autocmd FileType cobol setlocal formatoptions+=tc autoindent
    autocmd FileType cobol nnoremap <buffer> <F10> :call RodarCobol()<CR>
augroup END

" --- MÁSCARA AUTOMÁTICA COBOL ---
function! CreateCobolTemplate()
    if line('$') == 1 && getline(1) == ''
        let l:prog = toupper(expand("%:t:r"))
        call append(0, [
            \ "       IDENTIFICATION DIVISION.", 
            \ "       PROGRAM-ID. " . l:prog . ".", 
            \ "       AUTHOR. CERBERO.", 
            \ "       *", 
            \ "       ENVIRONMENT DIVISION.", 
            \ "       *", 
            \ "       DATA DIVISION.", 
            \ "       WORKING-STORAGE SECTION.", 
            \ "       *", 
            \ "       PROCEDURE DIVISION.", 
            \ "       MAIN-PROCEDURE.", 
            \ "           DISPLAY 'OLA NEOVIM'.", 
            \ "           STOP RUN.", 
            \ "       END PROGRAM " . l:prog . "."])
        call cursor(12, 11)
    endif
endfunction
autocmd BufNewFile *.cob,*.cbl call CreateCobolTemplate()

" --- EVOLUÇÃO MÉDICA (ROBUSTA) ---
function! GerarEvolucaoMedica()
    let l:paciente = input('Nome do Paciente: ')
    if l:paciente == '' | return | endif
    let l:data = input('Data (DD/MM/AAAA): ')
    if l:data == '' | return | endif

    let l:paciente_und = substitute(l:paciente, ' ', '_', 'g')
    let l:data_slug = substitute(l:data, '/', '-', 'g')
    let l:script = expand('~/EXAMESPDF/gerar_evolucao.py')
    let l:arquivo_txt = expand('~/EXAMESPDF/') . l:paciente_und . '/evolucao_' . l:paciente_und . '_' . l:data_slug . '.txt'

    echo "\nProcessando..."
    let l:cmd = 'python3 ' . shellescape(l:script) . ' ' . shellescape(l:paciente) . ' ' . shellescape(l:data)
    let l:res = system(l:cmd)

    if filereadable(l:arquivo_txt)
        let l:linhas = readfile(l:arquivo_txt)
        call append(line('.'), l:linhas)
        call delete(l:arquivo_txt)
        echo "\nSucesso! Evolução inserida."
    else
        echo "\nErro: " . l:res
    endif
endfunction
nnoremap <leader>ev :call GerarEvolucaoMedica()<CR>

" --- BARRA DE STATUS COLORIDA (FINAL) ---
hi StatusLine cterm=NONE guibg=#C1C2D0 guifg=#000000
autocmd InsertEnter * hi StatusLine guibg=#7BC86F guifg=#000000
autocmd InsertLeave * hi StatusLine guibg=#C1C2D0 guifg=#000000
set statusline=%#StatusLine#\ %{toupper(mode())}\ \|\ %f%m\ \|\ %l/%L\ \|\ Col:\ %c
