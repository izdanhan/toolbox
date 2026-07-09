# misc
# alias dl-yt-mv="dl-yt-mv.sh"
alias la="lsd -al"
alias ff="clear && fastfetch"
alias fr="fresh"
alias nano="fresh"
alias weather="curl wttr.in/tampere"
alias disks="lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT"
alias help-apps="glow ~/git/toolbox/docs/linux/terminal_apps.md"
alias help-cs="glow ~/git/toolbox/docs/linux/terminal_cheatsheet.md"

# flatpak
alias fl-in="flatpak install"
alias fl-rm="flatpak uninstall"
alias fl-up="flatpak update"
alias fl-r="flatpak run"

# apt
#alias apt="nala"
alias ap-in="sudo apt install"
alias ap-up="sudo apt update && sudo apt full-upgrade"
alias ap-s="apt search"
alias ap-i="apt show"

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
alias dn-up="sudo dnf upgrade"
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

