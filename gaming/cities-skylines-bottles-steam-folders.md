# Cities Skylines folders

## Steam

### Mods

```bash
/home/daniel/.local/share/Steam/steamapps/workshop/content/255710/

```

### Saves

```bash
"/home/daniel/.local/share/Steam/userdata/88067014/255710/remote/"

```


### Optimal Steam proporties for desktop

```bash
MANGOHUD=1 DXVK_CONFIG="dxgi.maxFrameRate=90" __GL_SHADER_DISK_CACHE=1 __GL_SHADER_DISK_CACHE_SIZE=5368709120 gamemoderun %command%

```


## Bottles

### Mods

```bash
"/home/daniel/.var/app/com.usebottles.bottles/data/bottles/bottles/Cities-Skylines/drive_c/users/steamuser/AppData/Local/Colossal Order/Cities_Skylines/Addons/Mods"

```


### Saves

```bash
"/home/daniel/.var/app/com.usebottles.bottles/data/bottles/bottles/Cities-Skylines/drive_c/users/steamuser/AppData/Local/Colossal Order/Cities_Skylines/Saves"

```

### Optimal Bottles settings for desktop

To guarantee proper DX11/DX12 to Vulkan translation and handling of large-scale assets, adjust these toggles inside your Bottle's **Preferences**:

#### 1. Components (Runners & Libraries)

* **Runner:** Use **Soda** (Bottles' optimized Wine-GE downstream) or install/inject **GE-Proton** into Bottles using a tool like *Vulkan-Caps-Viewer* or *ProtonUp-Qt*. Do not use standard vanilla Wine.
* **DXVK:** **Enabled** (Crucial. Cities: Skylines runs on DirectX 11; DXVK translates this to Vulkan seamlessly).
* **VKD3D:** Enabled (Only matters if you are playing *Cities: Skylines II*, which uses DX12).

#### 2. System Performance Toggles

* **Esync / Fsync:** **Enabled**. These optimize multi-threaded CPU synchronization. Since you are on a Ryzen 9 5900X (12 cores / 24 threads), this dramatically alleviates the simulation bottleneck.
* **Discrete GPU:** **Enabled** (Forces the container to bind explicitly to your RTX 3080).

#### 3. Environment Variables (Crucial for Nvidia + Unity Engine)

Go to **System** -> **Environment Variables** within your bottle configuration and add the following keys to optimize Nvidia's pipeline cache and memory limits:

| Variable | Value | Description |
| --- | --- | --- |
| `__GL_SHADER_DISK_CACHE` | `1` | Forces Nvidia driver to cache shaders, eliminating mid-game stuttering. |
| `__GL_SHADER_DISK_CACHE_SIZE` | `5368709120` | Sets cache size to 5GB to handle massive mod loads. |
| `DXVK_ASYNC` | `1` | Helps eliminate shader compilation stutter if using an older DXVK version. |



### Optimal Bottles settings for laptop ThinkPad T14s Gen 4

Because your laptop runs an **AMD Ryzen 7 Pro 7840U with Radeon 780M integrated graphics** (unlike your desktop's dedicated Nvidia RTX 3080), your Bottles configuration must focus heavily on **Vulkan memory optimization** and **CPU thread efficiency** rather than raw bandwidth.

The 780M is an incredible iGPU, but it shares your 32 GB of system RAM. If Bottles isn't configured correctly, the driver will starve the iGPU of VRAM when loading all your DLCs and map themes.

Apply these specific settings inside your Laptop's Bottle preferences:

---

## 1. Core Components & Performance Drivers

* **Runner:** Use **Soda** or **GE-Proton** (via ProtonUp-Qt). Avoid vanilla Wine.
* **DXVK:** **Enabled**. This converts the game's DX11 calls to Vulkan.
* **Esync + Fsync:** **Enabled**. Your Ryzen 7 Pro 7840U has 8 cores and 16 threads. Enforcing Fsync reduces CPU overhead dramatically during heavy simulation calculations.

---

## 2. Advanced Environment Variables (Crucial for AMD iGPU)

Go to **System** -> **Environment Variables** inside your bottle and add the following keys. These force the AMD Vulkan driver (RADV) to optimize memory allocation and shader caching for shared system memory:

| Variable | Value | Description |
| --- | --- | --- |
| `RADV_PERFTERRAIN` | `1` | Optimizes primitive shading lines on AMD drivers—directly stabilizes performance when viewing terrain heights or map contours. |
| `DXVK_ASYNC` | `1` | Forces asynchronous shader compilation. Essential on the 780M to prevent sudden frame drops when rotating the camera over dense zones. |
| `radv_zero_vram` | `true` | Cleans up allocated VRAM pages inside your shared system RAM instantly, preventing memory leaks when loading custom assets like `SCT-Homecoming`. |

---

## 3. Handling the 144Hz VRR Flickering on Laptop

If your laptop screen also utilizes a high-refresh variable rate display, you must cap the framerate to prevent adaptive sync stuttering.

Since the 780M will operate closer to the 40–60 FPS margin when managing complex simulations, do not try to cap it at 141 FPS like your desktop. Instead, go to your Bottle graphics preferences, turn on **MangoHud**, and pass this strict limitation:

```text
fps_limit=30

```

*Why 50?* Locking the engine to a tight, achievable integer inside your monitor’s VRR window prevents the display backlight from pulsing when the simulation hits a massive pathfinding calculation spike.

---

## 4. In-Game Adjustment for the AMD iGPU

When you launch the game via Bottles on the laptop, go to the options graphics menu and explicitly set **Texture Quality to Medium** or **High**, but drop **Shadow Distance to Low**. Shadow rendering on AMD integrated architectures eats up critical compute cycles that the simulation needs to keep the game clock running at 3x speed.
