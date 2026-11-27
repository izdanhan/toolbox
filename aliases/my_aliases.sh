# misc
# alias dl-yt-mv="dl-yt-mv.sh"
# alias la="lsd -al"
alias ls="lsd"
alias ll="lsd -l"
alias lt="lsd --tree --depth 2"
alias ff="clear && fastfetch"
alias fr="fresh"
alias weather='curl -fsS --max-time 5 "wttr.in/tampere?format=v2"' # or without ?format=v2 for standard view
alias disks='lsblk -o NAME,SIZE,TYPE,FSTYPE,LABEL,MOUNTPOINT,MODEL'
alias help-apps="glow ~/git/toolbox/docs/linux/terminal_apps.md"
alias help-cs="glow ~/git/toolbox/docs/linux/terminal_cheatsheet.md"
alias logs="journalctl -p 3 -xb"          # Show only errors/critical logs from current boot
alias ports="ss -tulpn"                   # Fast replacement for deprecated netstat
alias gpu="watch -n 1 nvidia-smi"

# flatpak
alias fl-in="flatpak install"
alias fl-rm="flatpak uninstall"
alias fl-up="flatpak update"
alias fl-r="flatpak run"
alias fl-cl="flatpak uninstall --unused -y"

# apt
alias ap-in="sudo apt install"
alias ap-rm="sudo apt remove"
alias ap-up="sudo apt update && sudo apt full-upgrade"
alias ap-s="apt search"
alias ap-i="apt show"
alias ap-cl="sudo apt autoremove --purge -y && sudo apt clean"

# YouTube download
# alias ytdl-video="ytdl-video.sh"
# alias ytdl-audio="ytdl-audio.sh"
alias ytdl="ytdl.sh"

# Ollama (docker)
alias ai='docker exec -it ollama ollama run qwen3.5:9b'
alias ai-fast='docker exec -it ollama ollama run qwen3.5:4b'
alias ai-vision='docker exec -it ollama ollama run gemma4:e4b'
alias ai-ps='docker exec -it ollama ollama ps'
alias ai-ls='docker exec -it ollama ollama list'

# apt > nala
#alias ap-in="sudo nala install"
#alias ap-up="sudo nala update && sudo nala full-upgrade"
#alias ap-s="nala search"
#alias ap-i="nala show"

# nala
alias nl-in="sudo nala install"
alias nl-up="sudo nala update && sudo nala full-upgrade"
alias nl-s="nala search"
alias nl-i="nala show"
alias nl-h="nala history"

# dnf
alias dn-up="sudo dnf upgrade --refresh"
alias dn-in="sudo dnf install"
alias dn-rm="sudo dnf remove"
alias dn-s="dnf search"
alias dn-i="dnf info"

# pacman
alias p-up="sudo pacman -Syu"
alias p-in="sudo pacman -S "
alias p-rm="sudo pacman -R "
alias p-s="pacman -Ss "
alias p-i="pacman -Si "

# Ollama & AI Management
alias ai-up="podman start open-webui && sudo systemctl start ollama"
alias ai-down="podman stop open-webui && sudo systemctl stop ollama"
alias ai-status="podman stats open-webui"

