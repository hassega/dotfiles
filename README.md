*Ambiente configurado e gerenciado com a ajuda da **LumiLoka** ✨*

# 💻 Apple Silicon M3 Max | Arch Linux ARM64 | Parallels Desktop 🚀

> **Atenção:** Este ambiente de alta performance é executado em um **MacBook Pro M3 Max** via **Parallels Desktop**, rodando **Arch Linux ARM** com a fluidez do **Hyprland**.

---

## 🛠️ Stack de Software & Hardware

*   **Processador:** [Apple M3 Max](https://www.apple.com) (Arquitetura ARM64).
*   **Virtualização:** [Parallels Desktop](https://www.parallels.com).
*   **Window Manager:** [Hyprland](https://hyprland.org) (Wayland).
*   **Barra de Status:** [Waybar](https://github.com).
*   **💾 Legado:** **Microsoft Fortran 5.1** rodando via **DOSBox-X** (Emulação x86).

## 📁 Estrutura de Pastas (Gerenciada com GNU Stow)

*   `hypr/`: Atalhos de janelas e configurações gráficas.
*   `waybar/`: Estilo e módulos da barra superior.
*   `rofi/`: Temas para o launcher de apps.
*   `fortran_env/`: O ambiente de desenvolvimento clássico:
    *   `dosprojs/`: Compiladores e imagens de disco (.img).
    *   `Fortran/`: Meus códigos-fonte (`.FOR`) e scripts de automação.

## 🪄 Comandos Mágicos (Aliases LumiLoka)

Configurados no meu `.bashrc` para máxima produtividade:


| Comando | O que faz? |
| :--- | :--- |
| `dotsave` | Sincroniza TUDO com o GitHub em um único comando. |
| `magic` | Abre o MS Fortran 5.1 direto no DOSBox-X. |
| `wipe` | Limpa o terminal e o buffer de rolagem visual. |
| `temp` / `mem` | Monitora a saúde do M3 Max (CPU/RAM). |
| `sb` | Aplica mudanças no bashrc instantaneamente. |

## 🚀 Instalação Rápida

```bash
git clone git@github.com:hassega/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow hypr waybar rofi fortran_env
