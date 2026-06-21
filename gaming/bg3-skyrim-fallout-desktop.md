On your desktop setup (**AMD Ryzen 9 5900X, 32GB RAM, Nvidia RTX 3080** running **Fedora 44 KDE Plasma**), the physics and bottleneck dynamics completely flip.

You aren't restricted by low mobile power limits, and you are dealing with a beefy discrete GPU coupled with 12 Zen 3 processing cores. Your focus shifts completely to crushing pipeline compilation lag, exploiting Nvidia’s proprietary driver stack, and maintaining strict frame-rate targets to avoid engine breaking.

---

## 1. Compatibility Matrix

Unlike the laptop, your desktop **can leverage the bleeding-edge stack**.

* **Baldur's Gate 3:** Run this on **Proton-CachyOS 11.0**. Your RTX 3080 handles Vulkan calls natively, and Proton 11's Nvidia Descriptor Heap integration significantly stabilizes frame pacing in heavy zones.
* **Skyrim & Fallout 4:** Remain locked to **Proton-GE 10-34**. The staging frame-cap regression under Wine 11 affects the desktop exactly the same as the laptop—keep these legacy games on the stable GE 10 branch to preserve full compute execution.

---

## 2. Desktop Game Deployments

### Baldur's Gate 3 (Desktop Configuration)

Since you are on an Nvidia card, you **do not use** `PROTON_DXVK_GPLASYNC=1`. Nvidia handles shader pipelines cleanly natively via the driver's built-in cache layers.

**Launch Options:**

```bash
MANGOHUD=1 __GL_SHADER_DISK_CACHE_SIZE=12000000000 gamemoderun %command% --skip-launcher --vulkan

```

* **`__GL_SHADER_DISK_CACHE_SIZE=12000000000`**: This expands Nvidia’s disk cache barrier to roughly 12GB explicitly for this prefix. It ensures Fedora won't aggressively clear out compiled pipelines, eliminating random micro-stuttering during long play sessions.

**In-Game Scaling:**
Turn off FSR. Since you have an RTX 3080, run at your monitor's native target and turn on **NVIDIA DLSS** directly in the menu to **Quality** mode. (No OptiScaler variables are needed because you have the physical Tensor cores).

---

### Skyrim SE/AE & Fallout 4 (Desktop Configuration)

The principal issue with running Bethesda's Creation Engine on a desktop monitor with high refresh rates (144Hz+) is that the game engine's internal physics will decouple and break if the framerate drifts over 60 FPS.

**Launch Options (Skyrim):**

```bash
MANGOHUD=1 gamemoderun %command% --skse

```

**Launch Options (Fallout 4):**

```bash
MANGOHUD=1 PROTON_NO_WM_DECORATION=1 gamemoderun %command%

```

**Critical Desktop Frame Capping (Mandatory):**
Because you have a 12-core CPU and an RTX 3080, these games will naturally shoot up to 150+ FPS and instantly break the internal game logic. You must clamp them.

1. Open your global or local MangoHud configuration file on Fedora:
```bash
nano ~/.config/mangohud/mangohud.conf

```


2. Insert this exact target argument to enforce engine discipline:
```text
fps_limit=60

```



*(Ensure you also apply the `bEnableWetnessMaterials=0` modification inside your Fallout 4 prefix `Documents/My Games/Fallout4/Fallout4Prefs.ini` as outlined previously, as it impacts the Nvidia proprietary driver pipeline under RADV/Vulkan translations as well).*
