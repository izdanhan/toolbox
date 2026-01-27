
***

# 03 - Software Configuration Guide

## Table of Contents
1.  [Installation Philosophy](#installation-philosophy)
2.  [Windows 11 Software](#windows-11-software)
3.  [Fedora Linux Software](#fedora-linux-software)
4.  [Cross-Platform Configuration](#cross-platform-configuration)
5.  [Application-Specific Settings](#application-specific-settings)

## Installation Philosophy

This guide prioritizes:
1.  **Performance:** Leveraging NVIDIA GPU acceleration wherever possible
2.  **Workflow Consistency:** Using similar tools across platforms when feasible
3.  **Isolation:** Keeping production environments stable while allowing experimentation
4.  **Organization:** Maintaining the established storage structure from previous guides

## Windows 11 Software

### Creative Suite
| Application | Purpose | Installation Notes |
| :--- | :--- | :--- |
| **DaVinci Resolve** | Video editing/color grading | Download from blackmagicdesign.com. Install Studio Drivers first. |
| **Affinity Photo v2** | Photo editing | Use your existing license. Enable OpenCL acceleration in Preferences > Performance. |
| **Affinity Designer v2** | Vector graphics | Same license as Photo. |
| **Affinity Publisher v2** | Desktop publishing | Complete the Affinity trilogy. |
| **OBS Studio** | Recording/streaming | Set recording path to `D:\OBS_Recordings\` in Settings > Output. |
| **Blender** | 3D modeling/animation | Enable CUDA acceleration in Edit > Preferences > System > Cycles Render Devices. |

### Gaming & Multimedia
| Application | Purpose | Configuration |
| :--- | :--- | :--- |
| **Steam** | Game library | Enable Steam Play for all titles in Settings > Compatibility. |
| **GOG Galaxy** | DRM-free games | Optional for GOG library management. |
| **Kodi** | Media center | Set content sources to `E:\MediaLibrary\` for movies/TV shows. |
| **MPC-HC** | Video playback | Lightweight alternative to built-in media players. |

### Utilities & Productivity
| Application | Purpose | Notes |
| :--- | :--- | :--- |
| **FreeFileSync** | Backup/mirroring | Create sync pairs for `E:\` to `F:\` mirroring. |
| **WinDirStat** | Disk space analyzer | Visualize storage usage. |
| **Visual Studio Code** | Code editor | Install WSL extension for Linux development. |
| **Git** | Version control | Essential for development work. |

## Fedora Linux Software

### Installation Methods
1.  **Native RPM:** `sudo dnf install <package>`
2.  **Flatpak:** `flatpak install flathub <application>`
3.  **AppImage:** Download and make executable

### Creative Applications
```bash
# Native packages
sudo dnf install kdenlive darktable krita gimp blender inkscape

# Flatpaks (recommended for latest versions)
flatpak install flathub org.kde.kdenlive
flatpak install flathub org.darktable.Darktable
flatpak install flathub org.kde.krita
flatpak install flathub org.gimp.GIMP
flatpak install flathub org.blender.Blender
flatpak install flathub org.inkscape.Inkscape
```

### Development Tools
```bash
# Core development stack
sudo dnf install git python3-pip nodejs npm java-latest-openjdk
sudo dnf groupinstall "Development Tools" "Development Libraries"

# Containers & virtualization
sudo dnf install distrobox podman docker

# Ollama for LLMs
curl -fsSL https://ollama.com/install.sh | sh
```

### Multimedia & Utilities
```bash
# Video acceleration
sudo dnf install ffmpeg mesa-va-drivers

# Additional utilities
sudo dnf install gnome-disk-utility timeshift
```

## Cross-Platform Configuration

### Visual Studio Code Settings
Create `~/.config/Code/User/settings.json` (Linux) and `%APPDATA%\Code\User\settings.json` (Windows):

```json
{
  "editor.fontSize": 14,
  "editor.tabSize": 2,
  "files.autoSave": "afterDelay",
  "git.autofetch": true,
  "workbench.colorTheme": "Default Dark Modern",
  "terminal.integrated.defaultProfile.linux": "bash",
  "window.title": "${dirty}${activeEditorShort}${separator}${rootName}${separator}${profileName}",
  "python.linting.enabled": true
}
```

### Git Configuration
Set globally on both systems:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global core.editor "code --wait"
git config --global init.defaultBranch "main"
```

## Application-Specific Settings

### DaVinci Resolve (Windows)
1.  **Project Settings:**
    - Set timeline format to 3840x2160 UHD if working with 4K footage
    - Enable "Use GPU for AI" in System > AI Acceleration
2.  **Media Storage:**
    - Add `D:\Resolve_Cache` as first cache location
    - Set "Capture and Playback" to 30 fps for smooth editing
3.  **Color Management:**
    - Set color science to DaVinci YRGB
    - Timeline color space: Rec.709-A

### Kdenlive (Linux)
1.  **Settings > Configure Kdenlive:**
    - Set default project folder to `/home/username/MediaProjects/`
    - Enable "Proxy Clips" for 4K editing
    - Set proxy resolution to 1280x720
2.  **Playback Settings:**
    - Enable GPU acceleration if available
    - Set preview resolution to 720p for smoother editing

### OBS Studio (Both Platforms)
1.  **Output Settings:**
    - Recording format: mkv (can be changed to mp4 after recording)
    - Encoder: NVIDIA NVENC H.264 (or H.265 for better compression)
    - Rate control: CQP (18-22 for good quality)
2.  **Advanced Settings:**
    - Enable "Automatically remux to mp4" for recorded files
    - Set recording path to your scratch drive

### Blender (Both Platforms)
1.  **Preferences > System:**
    - Enable CUDA for Cycles rendering
    - Select your RTX 3080 GPU
2.  **File Paths:**
    - Set temporary directory to scratch drive
    - Enable "Save Versions" with 2-3 backups

### Ollama Configuration
Create `~/.ollama/config.json` (Linux) or `C:\Users\Username\.ollama\config.json` (Windows):

```json
{
  "models": "/mnt/archive/Ollama_Models",
  "runs": {
    "accelerator": "cuda",
    "numa": true
  }
}
```

## Maintenance Scripts

Create these scripts for routine maintenance:

### Windows Cleanup Script (`cleanup.ps1`)
```powershell
# Clean temporary files
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# Clear browser caches
Remove-Item -Path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:LOCALAPPDATA\Mozilla\Firefox\Profiles\*\cache2\*" -Recurse -Force -ErrorAction SilentlyContinue

# Clear scratch drive (keep last 7 days)
Get-ChildItem "D:\OBS_Recordings\" | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-7)} | Remove-Item -Recurse -Force
```

### Linux Maintenance Script (`maintenance.sh`)
```bash
#!/bin/bash
# Update system
sudo dnf update -y
flatpak update -y

# Clean package cache
sudo dnf autoremove -y
sudo dnf clean all

# Clear user cache
rm -rf ~/.cache/*
rm -rf ~/.thumbnails/*

# Clear scratch drive (keep last 7 days)
find /mnt/scratch -type f -mtime +7 -delete
```

Make the Linux script executable: `chmod +x maintenance.sh`

This software configuration establishes a robust creative environment across both operating systems while maintaining consistency in your workflow. The next guide will focus on optimizing your workflow between these applications and systems.

***

## Repository Structure
| File      | Description   |
|-----------|---------------|
| README.md | [Overview and hardware summary](README.md)
| 01_OS_Setup.md | [Dual-boot configuration guide](01_OS_Setup.md)
| 02_Storage_Strategy.md | [Storage layout and management](02_Storage_Strategy.md)
| 03_Software_Configuration.md | [Creative software setup](03_Software_Configuration.md)
| 04_Workflow_Management.md | [Cross-platform workflow implementation](04_Workflow_Management.md)
| 05_Lab_Environment.md | [Distro-hopping and experimentation setup](05_Lab_Environment.md)
| 06_Network_Sharing.md | [Media sharing and network configuration](06_Network_Sharing.md)
