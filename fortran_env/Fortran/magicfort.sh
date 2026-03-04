#!/bin/bash
#!/bin/bash
# Força o título da janela para a regra do Hyprland
echo -ne "\033]0;MagicFort-Terminal\007"

WATCH_DIR="/home/cerbero/Fortran"
FORTRAN_FILE="PROGRAMA.FOR"
# ... resto do código anterior ...
# Configurações de caminhos
DOSBOX_BIN="dosbox-x"
FORTRAN_FILE="PROGRAMA.FOR"
EXE_FILE="PROGRAMA.EXE"

# Garante que o diretório existe
mkdir -p "$WATCH_DIR"

clear
echo "🚀 [MagicFort] Especialista Hyprland/Arch M3 Max"
echo "📡 Monitorando: $WATCH_DIR/$FORTRAN_FILE"
echo "------------------------------------------------"

# Loop de monitoramento com inotify-tools
while inotifywait -q -e close_write "$WATCH_DIR/$FORTRAN_FILE"; do
    echo "⚡ Alteração detectada! Iniciando ciclo de compilação..."

    # Executa o ciclo no DOSBox-X
    # /c no FL compila, LINK gera o executável
    $DOSBOX_BIN -silent -exit \
        -c "MOUNT C $WATCH_DIR" \
        -c "C:" \
        -c "FL /c $FORTRAN_FILE" \
        -c "LINK ${FORTRAN_FILE%.*}.OBJ;" \
        -c "CLS" \
        -c "echo --- SAIDA DO PROGRAMA FORTRAN ---" \
        -c "$EXE_FILE" \
        -c "echo." \
        -c "PAUSE" > /dev/null 2>&1

    # Limpa arquivos objetos e listagens temporárias para manter o home/cerbero limpo
    rm -f "$WATCH_DIR"/*.OBJ "$WATCH_DIR"/*.LST
    echo "✅ Ciclo finalizado. Aguardando novo save no $FORTRAN_FILE..."
    echo "------------------------------------------------"
done

