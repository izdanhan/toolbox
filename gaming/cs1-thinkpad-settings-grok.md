# Cities Skylines: Optimal settings for ThinkPad T14s Gen 4 on Linux

**For your ThinkPad T14s Gen 4 (32 GB RAM, 8 GB reserved for iGPU) on Ubuntu 26.04 LTS, here are the tailored optimal settings for Cities: Skylines 1.**

Your hardware (likely AMD Ryzen Pro with Radeon 740M/780M iGPU, or Intel Iris Xe variant) is solid for CS1 on Linux thanks to great Mesa drivers and Proton support. The 32 GB system RAM + 8 GB allocated to iGPU gives you good headroom for medium cities and moderate mods.

### Steam/Proton Setup (Critical on Ubuntu)
1. **Use Proton** (CS1 has a native Linux version, but **Proton is often more stable with mods**):
   - Right-click the game → Properties → Compatibility → Force **Proton Experimental** or **GE-Proton** (latest, e.g., GE-Proton10-xx via ProtonUp-Qt).
   - Install **ProtonUp-Qt** (Flatpak) for easy GE-Proton management.

2. **Launch Options** (add in Properties):
   ```
   WINEDLLOVERRIDES='winhttp=n,b' %command%
   ```
   Or try for AMD iGPU performance:
   ```
   RADV_PERFTEST=nggc PROTON_USE_NTSYNC=1 %command%
   ```

3. **Other tweaks**:
   - Run Steam in **X11** session if using Wayland (better compatibility sometimes: `steam -s` or log out and select X11).
   - Update Mesa drivers: `sudo apt update && sudo apt upgrade` (or use the latest from Ubuntu repositories/oibaf PPA for AMD/Intel).

### In-Game Graphics Settings
Start with **Low** preset and adjust:

- **Resolution**: Native (e.g., 1920x1200) or scale down to **1600x1000** / **1440x900** for better FPS.
- **Graphics Quality**: Low / Very Low (especially for larger cities).
- **Shadows**: Off or Low (major performance killer on iGPU).
- **Anti-Aliasing**: Off.
- **Textures**: Medium (your 8 GB iGPU allocation helps here).
- **Draw Distance / LOD**: Low.
- **Anisotropic Filtering**: Off.
- **VSync**: On (prevents tearing).
- **Depth of Field, Motion Blur, Film Grain, Reflections**: All **Off**.
- **Advanced**: Geometry cache ~2-4 GB if available; limit assets/mods.

**Expected Performance**:
- Small/early cities: 50–70+ FPS.
- Medium cities (20–60k pop, some mods): 35–55 FPS.
- Large cities/heavy mods: 25–40 FPS — use simulation pause, FPS Booster mod, and asset limits.

### Linux/Ubuntu System Optimizations
- **Power Profile**: Use "Performance" mode (via `tlp` or GNOME extension / Lenovo tools if available). Keep it plugged in.
- **Close background apps**: Browsers, etc., eat RAM/CPU.
- **Mesa tweaks** (for AMD): Add environment variables like `RADV_PERFTEST=nggc` (as above).
- **Swap/ZRAM**: Ensure you have some swap (your 32 GB should be fine, but monitor with `htop`).
- **Mods for Performance**: Same essentials as before (Loading Screen Mod, FPS Booster, TM:PE). Limit total Workshop assets to ~500–1500 max on iGPU.

CS1 runs very well on Ubuntu with this setup — many users report smooth experiences on similar ThinkPads with AMD iGPUs.

If you share your exact CPU (Intel or AMD Ryzen model) and whether you're using Wayland or X11, I can refine this further. Enjoy building your city!