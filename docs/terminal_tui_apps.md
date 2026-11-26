# Terminal & TUI Apps Reference

A practical directory of terminal and TUI tools for system management, media, editing, file handling, and local AI—with project links, build dependency notes for **Ubuntu / Pop!_OS** and **Fedora**, and a few extras that fit a daily Linux workflow.

---

## Is `cargo install` Enough on Both Ubuntu and Fedora?

**Not always by itself.** `cargo install` compiles Rust crates on your machine, so any crate that links against C/C++ libraries (like D-Bus or PipeWire) or needs a compiler toolchain requires system build tools and `-devel` / `-dev` headers first. Also, not every tool on your list is a Rust crate published on `crates.io` (for example, `lazygit` is written in Go and `superfile` (`spf`) is written in Go).

### 1. Install `rustup` (Recommended Over Distro `cargo` Packages)
Distro `cargo` packages can lag behind newer Rust editions required by modern crates:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
```

### 2. System Build Dependencies

* **Ubuntu / Pop!_OS:**
  ```bash
  sudo apt update
  sudo apt install -y build-essential pkg-config clang curl libdbus-1-dev libpipewire-0.3-dev libssl-dev
  ```

* **Fedora:**
  ```bash
  sudo dnf install -y gcc gcc-c++ make pkg-config clang curl dbus-devel pipewire-devel openssl-devel
  ```

---

## Core Tools

### System, Network & Hardware
* **`bluetui`** — Terminal UI for managing Bluetooth adapters, scanning, pairing, and connecting devices via BlueZ.
  * Repo: [pythops/bluetui](https://github.com/pythops/bluetui)
  * Install: `cargo install bluetui` (requires D-Bus headers / `libdbus-1-dev` or `dbus-devel`)
* **`wiremix`** — Terminal audio mixer for PipeWire to inspect sinks/sources, adjust volumes, and route streams.
  * Repo: [tsowell/wiremix](https://github.com/tsowell/wiremix)
  * Install: `cargo install wiremix` (requires `libpipewire-0.3-dev` or `pipewire-devel`, `pkg-config`, and `clang`)
* **`nmtui-go`** — Terminal UI wrapper around NetworkManager (`nmcli`) for managing Wi-Fi and network connections without leaving the terminal.
  * Repo: [doeixd/nmtui-go](https://github.com/doeixd/nmtui-go)
  * Note: Check the repo's release/build instructions rather than assuming `cargo install` (named with `-go`, typically built with Go or distributed as a binary).
* **`caligula`** — Lightweight, user-friendly TUI for writing ISO/disk images to USB drives and SD cards with progress and verification.
  * Repo: [ifd3f/caligula](https://github.com/ifd3f/caligula)
  * Install: `cargo install caligula`

### Media, Files, Git & Editing
* **`lazygit`** — Fast terminal UI for Git workflows: staging hunks/lines, interactive rebase, branches, diffs, and commits.
  * Site / Repo: [lazygit.dev](https://lazygit.dev/) · [jesseduffield/lazygit](https://github.com/jesseduffield/lazygit)
  * Note: Written in Go—install via your distro package manager, Go toolchain, or GitHub release binary rather than `cargo install`.
* **`cliamp`** — Retro-inspired terminal audio and stream/radio player built in Rust.
  * Repo: [bjarneo/cliamp](https://github.com/bjarneo/cliamp)
  * Install: `cargo install cliamp` (check repo for audio backend dependencies on your distro)
* **`tui-tunes`** — Terminal music and podcast client with search, lyrics/transcripts, and theme support.
  * Repo: [5c0r/TuiTunes](https://github.com/5c0r/TuiTunes)
  * Note: Check the repository README for exact build/runtime requirements before installing.
* **`fresh`** — Terminal-based text editor/IDE aiming for familiar VS Code / Sublime-style usability, mouse support, menus, and extensibility.
  * Repo: [sinelaw/fresh](https://github.com/sinelaw/fresh)
  * Install: Follow the official install script or release instructions in the GitHub repository.
* **`spf` (`superfile`)** — Modern multi-pane terminal file manager with previews, tabs, and keyboard/mouse navigation.
  * Repo: [yorukot/superfile](https://github.com/yorukot/superfile)
  * Note: Written in Go—use the project's install script, package manager, or GitHub release rather than `cargo install`.
* **`ouch`** — CLI utility for painless compression and decompression across archive formats (`.tar.gz`, `.zip`, `.zst`, `.7z`, etc.) with a unified interface.
  * Repo: [ouch-org/ouch](https://github.com/ouch-org/ouch)
  * Install: `cargo install ouch`

### Local AI
* **`lazyllama`** — Fast, minimal terminal UI client for chatting with and switching between local Ollama models.
  * Repo: [Pommersche92/lazyllama](https://github.com/Pommersche92/lazyllama)
  * Install: `cargo install lazyllama`

---

## Handy Extras to Consider

* **`yazi`** — Fast async terminal file manager in Rust with rich previews and bulk file actions.
  * Site / Repo: [yazi-rs.github.io](https://yazi-rs.github.io/) · [sxyazi/yazi](https://github.com/sxyazi/yazi)
* **`cargo-binstall`** — Downloads pre-built binary releases when available so you don't have to compile every Rust tool from source.
  * Repo: [cargo-bins/cargo-binstall](https://github.com/cargo-bins/cargo-binstall)
* **`cargo-update`** — Adds `cargo install-update -a` to keep binaries installed via `cargo install` up to date.
  * Repo: [nabijaczleweli/cargo-update](https://github.com/nabijaczleweli/cargo-update)
* **`btop`** — Interactive resource monitor for CPU, memory, disks, network, and GPU processes (usually best installed via `apt` or `dnf` rather than building from source).
  * Repo: [aristocratos/btop](https://github.com/aristocratos/btop)
* **`glow`** — Terminal Markdown reader great for viewing local notes, cheatsheets, and `.md` docs right in the shell.
  * Repo: [charmbracelet/glow](https://github.com/charmbracelet/glow)