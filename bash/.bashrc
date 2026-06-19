# Enable the subsequent settings only in interactive sessions
case $- in
    *i*) ;;
      *) return;;
esac

# Desabilita oh-my-bash no terminal do PyCharm/JetBrains
if [[ "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ]]; then
    PS1='\[\e[0;32m\]\u@\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\$ '
    [[ -z "$VIRTUAL_ENV" && -f "venv/bin/activate" ]] && source venv/bin/activate
    return
fi

# Path to your oh-my-bash installation.
export OSH="${HOME}/.oh-my-bash"

# Set name of the theme to load
OSH_THEME="lambda"

# History config - formato BR + tamanho decente
HIST_STAMPS='[dd/mm/yyyy]'
HISTSIZE=10000
HISTFILESIZE=20000
export HISTCONTROL=ignorespace:ignoredups

# Which completions would you like to load?
completions=(git composer ssh)

# Which aliases would you like to load?
aliases=(general)

# Which plugins would you like to load?
plugins=(git bashmarks)

# Carrega oh-my-bash - SÓ UMA VEZ
#source "$OSH"/home/cerbero/.oh-my-bash/oh-my-bash.sh
source "$OSH"/oh-my-bash.sh

# --- VARIÁVEIS DE AMBIENTE E PATH ---
export TERMINAL=konsole
export SAL_USE_VCLPLUGIN=gtk3
export PATH="$HOME/.local/bin:$HOME/.local/bin/script:~/.npm-global/bin:/usr/local/sbin:$PATH"

# Homebrew Engine
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

# Carrega o ambiente do Rust/Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# --- MEUS ALIASES ---
alias Hyprland="start-hyprland"
alias bkp="sudo snapper -c root create --description \"Manual: \$(date +'%d/%m/%Y %H:%M')\""

# --- NAVEGAÇÃO E LISTAGEM ---
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -lah"
alias l="ls -CF"

# --- SEGURANÇA ---
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# --- UTILITÁRIOS E MONITORAMENTO ---
alias c="clear"
alias h="history -c"
alias meuip="curl ifconfig.me; echo"
alias mem="free -h"
alias cpu="top -bn1 | grep 'Cpu(s)'"
alias temp='lscpu | grep "CPU MHz" || echo "M3 Max voando baixo!"'

# --- LIMPEZA E GESTÃO DO BASH ---
alias eb="nano ~/.bashrc"
alias sb="source ~/.bashrc"
#alias nvim="/home/cerbero/AppImages/neovim"
#alias init='nvim ~/.config/nvim/init.vim'

alias ombb='rm /Users/hassega/.oh-my-bash/log/update.lock'
alias ombu='omb update'
#alias olp='ollama pull qwen2.5-coder:32b-instruct-q4_K_M' export OLLAMA_COLORS= 'template=bold;fg=cyan:response=bold;fg=yellow
alias olr='ollama run qwen2.5-coder:32b-instruct-q4_K_M'

# Alias para colocar a Qwen para dormir e avisar no terminal
alias oll="curl -s -m 2 http://localhost:11434/api/generate -d '{\"model\": \"qwen2.5-coder:32b-instruct-q4_K_M\", \"keep_alive\": 0}' > /dev/null & echo ' 💤💤💤 IA DORMIU!'"

# --- CONFIGURAÇÕES COBOL ---
alias cobrun='~/cobolProjects/run.sh'
alias cobclean='rm -rf ~/cobolProjects/build/* && echo "🧹 Pasta build limpa!"'
alias cobcode='code ~/cobolProjects'
alias cobc='gcobol'
alias cobol='code /home/cerbero/cobolProjects'

# --- AMBIENTE FORTRAN 5.1 ---
alias magic='bash ~/Fortran/magicfort.sh'
alias cdf='cd ~/Fortran'
alias conf-f51='nano ~/dosprojs/fortran.conf'
alias edit-for='nano ~/Fortran/PROGRAMA.FOR'
alias v-for='vim -u "$HOME/dotfiles/fortran_env/.vimrc_f51"'

# --- ATALHOS HYPRLAND/WAYBAR (Apontando para os locais ativos) ---
alias conf-hypr='nano ~/.config/hypr/hyprland.conf'
alias conf-waybar='nano ~/.config/waybar/config.jsonc'
alias style-waybar='nano ~/.config/waybar/style.css'

# --- GESTÃO DE DOTFILES & GIT ---
alias dotconf='cd ~/dotfiles && git fetch && git status && cd - > /dev/null'
alias dotcheck='cd ~/dotfiles && git fetch && git status && cd - > /dev/null'

# Função Git Corrigida e Segura
function dotsave() {
    local curr_dir=$(pwd)
    cd ~/dotfiles || return 1
    
    echo "🔄 Buscando atualizações remotas..."
    git fetch origin main
    
    echo "🔄 Checando mudanças locais..."
    if [[ -n $(git status --porcelain) ]]; then
        git add .
        git commit -m "Update configs: $(date +'%d/%m/%Y %H:%M')"
        echo "✓ Commit local criado com sucesso."
    else
        echo "ℹ Nenhuma alteração local detectada para salvar."
    fi
    
    echo "🔄 Sincronizando repositório com Git Pull Rebase..."
    if ! git pull --rebase origin main; then
        echo "❌ Conflito detectado no Rebase! Resolva manualmente em ~/dotfiles"
        cd "$curr_dir"
        return 1
    fi
    
    echo "🚀 Enviando dotfiles para a nuvem..."
    if git push origin main; then
        echo "✨ Tudo salvo na nuvem, mestre! Azhrael tá voando 🚀"
    else
        echo "❌ Falha ao enviar para o GitHub. Verifique sua conexão ou chaves."
    fi
    
    cd "$curr_dir"
}

# Modificado para não colidir com o comando 'scp' do sistema Linux
function myscript() {
    local dir="$HOME/.local/bin/script"
    mkdir -p "$dir"
    if [ -z "$1" ]; then
        cd "$dir" || return
    else
        local arq="$dir/$1.sh"
        if [ ! -f "$arq" ]; then
            echo "#!/bin/bash" > "$arq"
            chmod +x "$arq"
        fi
        v-for "$arq"
    fi
}
alias scp="myscript" # Atalho rápido mantido se você preferir digitar scp para os scripts

# Auto ativa venv - DEIXA NO FINAL DE TUDO
if [[ -z "$VIRTUAL_ENV" && -f "venv/bin/activate" ]]; then
    source venv/bin/activate
fi
