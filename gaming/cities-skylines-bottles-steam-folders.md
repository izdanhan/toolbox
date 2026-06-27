# Cities Skylines folders

## Steam

### Mods

```bash
/home/daniel/.local/share/Steam/steamapps/workshop/content/255710/

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
