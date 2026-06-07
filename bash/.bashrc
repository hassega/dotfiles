# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/cerbero/.oh-my-bash'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
# OSH_THEME="font"
OSH_THEME="lambda"
# OSH_THEME="nekonight_moon"
# OSH_THEME="nekonight"
## OSH_THEME="mairan"
# OSH_THEME="kitsune"

# If you set OSH_THEME to "random", you can ignore themes you don't like.
# OMB_THEME_RANDOM_IGNORED=("powerbash10k" "wanelo")
# You can also specify the list from which a theme is randomly selected:
# OMB_THEME_RANDOM_CANDIDATES=("font" "powerline-light" "minimal")

# Uncomment the following line to use case-sensitive completion.
# OMB_CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# OMB_HYPHEN_SENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you don't want the repository to be considered dirty
# if there are untracked files.
# SCM_GIT_DISABLE_UNTRACKED_DIRTY="true"

# Uncomment the following line if you want to completely ignore the presence
# of untracked files in the repository.
# SCM_GIT_IGNORE_UNTRACKED="true"

# History config - formato BR + tamanho decente
HIST_STAMPS='[dd/mm/yyyy]'
HISTSIZE=10000
HISTFILESIZE=20000
export HISTCONTROL=ignorespace:ignoredups  # Comando com espaço não salva + remove dups

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
# OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
# OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# To enable/disable Spack environment information
# OMB_PROMPT_SHOW_SPACK_ENV=true  # enable
# OMB_PROMPT_SHOW_SPACK_ENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

# If you want to reduce the initialization cost of the "tput" command to
# initialize color escape sequences, you can uncomment the following setting.
# This disables the use of the "tput" command, and the escape sequences are
# initialized to be the ANSI version:
#
#OMB_TERM_USE_TPUT=no

source "$OSH"/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

# Meus aliases
alias Hyprland="start-hyprland"

# --- CURSO DE BASH (LumiLoka v3.0) ---
function scp() {
    local dir="$HOME/.local/bin/script"
    mkdir -p "$dir"  # Garante que a pasta existe fisicamente
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

# --- CONFIGURAÇÕES DE CAMINHO (PATH) ---
# PATH - ordem importa: local primeiro, sem duplicar
export PATH="$HOME/.local/bin:$HOME/.local/bin/script:$PATH"

# Carrega o ambiente do Rust/Cargo (se o arquivo existir)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Libreoffice com gtk3
export SAL_USE_VCLPLUGIN=gtk3

# ==========================================================
# ---           ALIASES DA LUMILOKA (v3.1)               ---
# ==========================================================

# --- NAVEGAÇÃO E LISTAGEM ---
alias ..="cd .."                         # Sobe um nível de diretório
alias ...="cd ../.."                     # Sobe dois níveis de diretórios
alias ll="ls -lah"                       # Lista detalhada (inclui ocultos e tamanhos legíveis)
alias l="ls -CF"                         # Listagem simples em colunas

# --- SEGURANÇA (EVITA ACIDENTES) ---
alias rm="rm -i"                         # Pede confirmação antes de deletar
alias cp="cp -i"                         # Pede confirmação antes de sobrescrever ao copiar
alias mv="mv -i"                         # Pede confirmação antes de mover/renomear

# --- UTILITÁRIOS E MONITORAMENTO ---
alias c="clear"                          # Limpa a tela - com espaço na frente não salva no history
alias h="history"                        # Mostra o histórico de comandos
alias meuip="curl ifconfig.me; echo"     # Mostra seu IP externo rapidamente
alias mem="free -h"                      # Mostra memória RAM usada e livre
alias cpu="top -bn1 | grep 'Cpu(s)'"     # Resumo rápido do uso da CPU
# Mostra a frequência atual de cada núcleo do M3 Max (em MHz)
alias temp='lscpu | grep "CPU MHz" || echo "M3 Max voando baixo!"'

# --- LIMPEZA E GESTÃO DO BASH ---
alias wipe='printf "\033c"'              # Limpa tela e buffer (não dá pra rolar pra cima)
alias eb="nano ~/.bashrc"                # Abre este arquivo para editar
alias sb="source ~/.bashrc"              # Aplica as mudanças no terminal na hora
alias init='nvim ~/.config/nvim/init.vim'

# --- CONFIGURAÇÕES COBOL (Arch ARM) ---
# Atalho para compilar e rodar em um único comando
# Uso: cobrun arquivouivo.cob
alias cobrun='~/cobolProjects/run.sh'

# Atalho para limpar a pasta de executáveis
alias cobclean='rm -rf ~/cobolProjects/build/* && echo "🧹 Pasta build limpa!"'

# Atalho para abrir a pasta de projetos no VS Code
alias cobcode='code ~/cobolProjects'

# Garante que o gcobol seja o padrão para o comando cobc (compatibilidade)
alias cobc='gcobol'
alias cobol='code /home/cerbero/cobolProjects'

# --- GESTÃO DE DOTFILES & GIT ---
alias dotconf='cd ~/dotfiles && git fetch && git status && cd -' # Checa status remoto
alias dotcheck='cd ~/dotfiles && git fetch && git status && cd -'

function dotsave() {
    local curr_dir=$(pwd)
    cd ~/dotfiles || return 1

    echo "🔄 Checando mudanças locais..."
    if [[ -n $(git status --porcelain) ]]; then
        git add .
        git commit -m "Update configs: $(date +'%d/%m/%Y %H:%M')"
        echo "✓ Commit local criado"
    fi

    echo "🔄 Sincronizando com GitHub..."
    git pull --rebase origin main || {
        echo "❌ Conflito no rebase. Resolve com 'git status' em ~/dotfiles"
        cd "$curr_dir"
        return 1
    }

    git push origin main && echo "Tudo salvo na nuvem, mestre! ✨" || echo "Nada novo pra subir 🌟" || echo "Azhrael tá voando 🚀"
    cd "$curr_dir"
}

# --- AMBIENTE FORTRAN 5.1 (DOSBOX-X) ---
alias magic='bash ~/Fortran/magicfort.sh'     # Executa o script que abre o ambiente Fortran
alias cdf='cd ~/Fortran'                      # Vai direto para a pasta dos seus códigos .FOR
alias conf-f51='nano ~/dosprojs/fortran.conf' # Edita a config do DOSBox (Mounts e Drives)
alias edit-for='nano ~/Fortran/PROGRAMA.FOR'   # Edita seu código Fortran principal no nano

# --- ATALHOS HYPRLAND/WAYBAR (STOW) ---
alias conf-hypr='nano ~/dotfiles/hypr/.config/hypr/hyprland.conf'
alias conf-waybar='nano ~/dotfiles/waybar/.config/waybar/config.jsonc'

# Abre o Vim com a cara do Fortran 5.1
alias v-for='vim -u "$HOME/dotfiles/fortran_env/.vimrc_f51"'

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
