# Baldur's Gate 3

### Optimal settings

## Desktop (RTX 3080 / Ryzen 5900X)

**Target:** 1440p / 144Hz high-framerate stability.

### Steam Launch Options

Since you are running Fedora 44 KDE, you are on Wayland by default. Force the native SDL driver to bypass XWayland overhead:

Bash

```javascript
SDL_VIDEODRIVER=wayland %command%

```

### In-Game Settings

- **Resolution:** 2560x1440
- **Frame Rate Limit:** Enabled (Cap at 144)
- **Model Quality:** High
- **Texture Quality:** Ultra (The 3080 handles this easily)
- **Texture Filtering:** Anisotropic x16
- **Shadow Quality:** Medium *(Crucial for keeping 1% lows stable in Act 3/Lower City)*
- **Clouds/Fog Quality:** Medium
- **Anti-Aliasing:** TAA (Or DLSS Quality if your native build successfully exposes the `.so` library)
- **Ambient Occlusion:** On
- **FidelityFX Particle Effects:** On

Nvidia’s Linux driver stack on Wayland remains a headache, especially with VRR and multi-display refreshes. Pushing native 4K on a 10GB RTX 3080 while trying to guarantee a locked 60 FPS—especially in Act 3—requires aggressive tuning.

Since you are locked to 60Hz on the TV, your primary target is frame pacing stability, not raw output.

### Steam Launch Options

If you are sticking to the native build on your desktop, drop the Wayland environment variables completely if you are testing via X11 on Mint, or keep it if you are using Fedora 44 KDE. If using Fedora 44, add this to ensure the composition doesn't drop frames:

Bash

```javascript
__GL_GSYNC_ALLOWED=1 __GL_VRR_ALLOWED=1 %command%

```

### 4K In-Game Settings (RTX 3080 Target: Locked 60 FPS)

- **Resolution:** 3840x2160
- **Display Mode:** Fullscreen (Avoid borderless windowed on the TV to lower input lag and prevent desktop environment micro-stutters)
- **Frame Rate Limit:** Enabled (Cap at 58 or 60 to prevent erratic frame rendering)
- **V-Sync:** Enabled (Mandatory here since Nvidia on Linux won't negotiate a clean 60Hz over standard TV pipelines without tearing)

### Quality Settings

- **Texture Quality:** High *(Do not use Ultra. At 4K, the Ultra texture buffer can choke the 3080’s 10GB VRAM pool when mixed with dense geometry, causing sudden 1% low drops).*
- **Texture Filtering:** Anisotropic x16
- **Model Quality:** Medium *(Crucial CPU/GPU relief for dense areas).*
- **Shadow Quality:** Medium *(High destroys the 3080 at 4K resolution).*
- **Clouds Quality:** Medium
- **Fog Quality:** High *(Note: A known bug in the native Linux Vulkan renderer causes flickering black boxes during cutscenes if Fog is set to Medium/Low. Keep it on High).*

### Post-Processing & Upscaling

- **Nvidia DLSS:** Quality *(Native 4K will dip into the mid-40s in Act 3 on a 3080. DLSS Quality renders the internal resolution at 1440p, which looks virtually identical to native on a 4K TV from couch distance).*
- **Anti-Aliasing:** None (Overridden by DLSS)
- **Ambient Occlusion:** On
- **Depth of Field:** Off *(Saves overhead and removes unwanted blur).*
- **Subsurface Scattering:** Off *(High GPU cost for minimal visual return).*

## Laptop (ThinkPad T14s / Radeon 780M)

**Target:** Consistent 60 FPS at 1200p. The native Linux build was heavily optimized for AMD architecture (specifically for the Steam Deck), so performance here will be more consistent than via Proton.

### Steam Launch Options

Ubuntu 26.04 also runs Wayland by default. Keep the execution clean:

Bash

```javascript
SDL_VIDEODRIVER=wayland %command%

```

### In-Game Settings

- **Resolution:** 1920x1200
- **Frame Rate Limit:** Enabled (Cap at 60)
- **Texture Quality:** High *(Safe to use because you locked down 8GB of VRAM)*
- **Model Quality:** Medium
- **Instance Distance:** Medium
- **Shadow Quality:** Low *(Saves massive CPU/GPU cycles)*
- **Clouds/Fog Quality:** Low
- **FSR 2.2:** Ultra Quality or Quality *(Mandatory to maintain 60 FPS in dense areas)*
- **Ambient Occlusion:** Off
- **Depth of Field / God Rays:** Off *(Pure visual noise that degrades APU performance)*
