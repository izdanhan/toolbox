Baldur’s Gate 3 (BG3) is a massive stress test for the Ryzen 7 Pro 7840U, specifically because Act 3 (The Lower City) heavily bottlenecks the CPU threads while demanding intense asset streaming over memory channels.

Larian released a native Linux build of BG3 meant for the Steam Deck architecture, but it is unstable, unoptimized, and introduces asset streaming bugs on standard desktop Linux distributions like Ubuntu. **Avoid the native Linux container; stick to running the Windows binary via Proton.**

Unlike Bethesda games, BG3 flourishes on **Proton-CachyOS**, as long as you tap into the Vulkan backend and use asynchronous shader compilation pipelines.

---

## 1. The Tactical Steam Launch Stack

Right-click Baldur’s Gate 3 $\rightarrow$ **Properties** $\rightarrow$ **General** $\rightarrow$ **Launch Options**. Drop this exact string:

```bash
MANGOHUD=1 PROTON_DXVK_GPLASYNC=1 PROTON_USE_NTSYNC=1 gamemoderun %command% --skip-launcher --vulkan

```

### Strategic Analysis of the Arguments:

* **`--skip-launcher`**: Mandatory execution command. It kills Larian's third-party launcher, which drains continuous processing threads in the background and causes micro-stutters during heavy computational combat cycles.
* **`--vulkan`**: Bypasses the DX11 translation layer. On AMD RADV Mesa drivers (used by Ubuntu 26.04), Vulkan bypasses major CPU overhead, which is critical for making Act 3 playable on your 15W–28W mobile chip.
* **`PROTON_DXVK_GPLASYNC=1`**: Forces asynchronous pipeline generation. This is the ultimate tool for destroying the massive dialogue scene stuttering and asset-loading hitches common to BG3.
* **`PROTON_USE_NTSYNC=1`**: Leverages fast kernel-level synchronization primitives, maximizing instruction dispatching across your 8 Zen 4 cores.

---

## 2. Compatibility Tool Settings

Set the global game runner to **Proton-CachyOS 11.0** (or their latest 10.x iteration if you encounter a regression). Because BG3 doesn't rely on the legacy code path that triggers the frame-cap bug found in Bethesda's Creation Engine, the `-O3` micro-optimizations and instruction sets native to CachyOS builds will buy you an extra 4–6 FPS in high-density areas.

---

## 3. In-Game Graphics Matrix (7840U / Radeon 780M)

Boot the game directly into the graphics settings. Calibrate the engine to prioritize thread limits and memory constraints:

| Setting | Selection | Direct Tactical Reason |
| --- | --- | --- |
| **Resolution** | Native ($1920 \times 1200$ or $1920 \times 1080$) | Do not drop below native; we use dynamic scaling instead. |
| **Display Mode** | Borderless Window | Fixes desktop context switching hiccups on Wayland. |
| **Model Quality** | **Medium** | Lowering this drastically scales down CPU draw-call strain in cities. |
| **Texture Quality** | **High** | Your 32GB system memory easily accommodates high texturing allocation. |
| **Shadow Quality** | **Low** | Massive GPU resource drain on RDNA3 integrated compute units. |
| **Animation Level of Detail** | **Medium** | Tightly limits background CPU animation compute loops. |
| **AMD FSR 2.2** | **Balanced** or **Quality** | Mandatory upscaling path. Set to *Balanced* to maintain a stable ~45 FPS lock. |
| **FSR Sharpness** | `0.60` | Cleans up the typical temporal blur introduced by FSR reconstruction paths. |
| **Slow HDD Mode** | **ON** | Even on a fast NVMe drive like the 990 EVO, turning this **ON** forces the engine to aggressively cache asset textures in RAM, reducing random drop-in lag. |
| **Dynamic Crowds** | **OFF** | Absolutely non-negotiable for Act 3. Keeping this on will choke your mobile CPU threads down to sub-25 FPS. |

---

## 4. Stability Validation

If you notice character audio dropping out during fast cuts or camping transitions, open terminal and check your PipeWire/Pulse configurations. If the audio buffer underruns due to heavy CPU loads, add **`PULSE_LATENCY_MSEC=60`** directly to the beginning of your Steam launch command to force audio processing into an isolated safe buffer window.
